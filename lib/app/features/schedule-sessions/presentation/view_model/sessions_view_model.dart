import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/get_all_sessions_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/get_one_session_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class SessionsViewModel extends Cubit<SessionsStates> {
  final GetAllSessionsUseCase getAllSessionsUseCase;
  final GetOneSessionUseCase getOneSessionUseCase;

  SessionsViewModel(this.getAllSessionsUseCase, this.getOneSessionUseCase)
      : super(SessionsStates());
  Future<BaseResponse<SessionsModel>> getAllSessions() async {
    emit(state.copyWith(
      getAllSessionsStateParams: BaseState<SessionsModel>(isLoading: true),
    ));
    final response = await getAllSessionsUseCase.call();
    switch (response) {
      case SuccessResponse<SessionsModel>():
        emit(state.copyWith(
          getAllSessionsStateParams: BaseState<SessionsModel>(
            data: response.data,
            isLoading: false,
          ),
        ));
        return response;
      case ErrorResponse<SessionsModel>():
        emit(state.copyWith(
          getAllSessionsStateParams: BaseState<SessionsModel>(
            errorMessage: response.error.toString(),
            isLoading: false,
          ),
        ));
        return response;
    }
  }

  Future<BaseResponse<SessionEntity>> getOneSession(String id) async {
    emit(state.copyWith(
      getOneSessionStateParams: BaseState<SessionEntity>(isLoading: true),
    ));
    final response = await getOneSessionUseCase.call(id);
    switch (response) {
      case SuccessResponse<SessionEntity>():
        emit(state.copyWith(
          getOneSessionStateParams: BaseState<SessionEntity>(
            data: response.data,
            isLoading: false,
          ),
        ));
        return response;
      case ErrorResponse<SessionEntity>():
        emit(state.copyWith(
          getOneSessionStateParams: BaseState<SessionEntity>(
            errorMessage: response.error.toString(),
            isLoading: false,
          ),
        ));
        return response;
    }
  }
  DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);
  Map<DateTime, List<SessionEntity>> buildEventsMap(
    List<SessionEntity> sessions,
  ) {
    final Map<DateTime, List<SessionEntity>> map = {};
    for (final session in sessions) {
      if (session.startTime == null) continue;
      final date = normalize(DateTime.parse(session.startTime!).toLocal());
      map.putIfAbsent(date, () => []).add(session);
    }
    return map;
  }

  List<SessionEntity> getEventsForDay(
    DateTime day,
    Map<DateTime, List<SessionEntity>> eventsMap,
  ) {
    return eventsMap[normalize(day)] ?? [];
  }

  String formatDayLabel(DateTime day) {
    final now = DateTime.now();
    final normalized = normalize(day);
    final todayNorm = normalize(now);
    if (normalized == todayNorm) {
      return 'Today, ${DateFormat('EEEE, MMM d').format(day)}';
    }
    return DateFormat('EEEE, MMM d').format(day);
  }
  String formatTime(String? isoString) {
    if (isoString == null) return '';
    final dt = DateTime.parse(isoString).toLocal();
    return DateFormat('h:mm a').format(dt);
  }

  String formatDuration(String? start, String? end) {
    if (start == null || end == null) return '';
    final s = DateTime.parse(start);
    final e = DateTime.parse(end);
    final diff = e.difference(s).inMinutes;
    return '${diff}m';
  }

  String formatSessionDateTime(SessionEntity session) {
    if (session.startTime == null) return '';
    return DateFormat('d MMM yyyy, h:mm a')
        .format(DateTime.parse(session.startTime!).toLocal());
  }

  int sessionDurationMinutes(SessionEntity session) {
    if (session.startTime == null || session.endTime == null) return 0;
    return DateTime.parse(session.endTime!)
        .difference(DateTime.parse(session.startTime!))
        .inMinutes;
  }

  int spotsLeft(SessionEntity session) {
    return (session.maxParticipants ?? 0) - (session.currentParticipants ?? 0);
  }

  double sessionFillRatio(SessionEntity session) {
    final max = session.maxParticipants ?? 0;
    final current = session.currentParticipants ?? 0;
    if (max == 0) return 0;
    return (current / max).clamp(0.0, 1.0);
  }
    bool isSessionPast(SessionEntity session) {
    if (session.startTime == null) return false;
    return DateTime.parse(session.startTime!).toLocal().isBefore(DateTime.now());
  }

  bool isSessionFull(SessionEntity session) {
    final max = session.maxParticipants ?? 0;
    final current = session.currentParticipants ?? 0;
    return max > 0 && current >= max;
  }

  bool isSessionClosedDueToLowBookings(SessionEntity session) {
    if (session.startTime == null) return false;
    final start = DateTime.parse(session.startTime!).toLocal();
    final twoHoursBefore = start.subtract(const Duration(hours: 2));
    return DateTime.now().isAfter(twoHoursBefore) &&
        (session.currentParticipants ?? 0) < 2;
  }
  String getBookingStatusText({
    required dynamic locale,
    required bool isAlreadyBooked,
    required bool isPast,
    required bool isClosedDueToLowBookings,
    required bool isFull,
    required bool isWaitingListJoined,
    required bool hasPlan,
    required bool hasAnyActivePlan,
    String? planName,
    int sessionsUsed = 0,
    int sessionsTotal = 0,
    required String paymentOption,
    required SessionEntity session,
  }) {
    if (isAlreadyBooked) return locale.alreadyBooked;
    if (isPast) return locale.thisSessionHasEnded;
    if (isClosedDueToLowBookings) return locale.bookingClosed;
    if (isFull && isWaitingListJoined) return locale.youAreOnTheWaitingListMessage;
    if (isFull && hasAnyActivePlan) return locale.thisSessionIsFullSoJoinTheWaitingList;
    if (isFull && !hasAnyActivePlan) return locale.thisSessionIsFullyBooked;
    if (hasPlan) {
      return 'Covered by: ${planName ?? ''} • $sessionsUsed/$sessionsTotal sessions used';
    }
    if (paymentOption == 'buy_plan') return locale.buyAPlanToBookThisSession;
    return 'SAR ${session.service?.price ?? ''} ${locale.dueNow}';
  }

  String getBookingButtonLabel({
    required dynamic locale,
    required bool isAlreadyBooked,
    required bool isPast,
    required bool isFull,
    required bool isWaitingListJoined,
    required bool hasPlan,
    required bool hasAnyActivePlan,
    required String paymentOption,
  }) {
    if (isAlreadyBooked) return locale.booked;
    if (isPast) return locale.sessionEnded;
    if (isFull && isWaitingListJoined) return locale.onWaitingList;
    if (isFull && hasAnyActivePlan) return locale.joinWaitingList;
    if (isFull && !hasAnyActivePlan) return locale.fullyBooked;
    if (hasPlan) return locale.bookThisSession;
    if (paymentOption == 'buy_plan') return locale.buyPlan;
    return locale.bookAndPay;
  }

  Color getButtonColor({
    required BuildContext context,
    required bool hasPlan,
    required bool isAlreadyBooked,
    required bool isPast,
    required bool isFull,
    required bool hasAnyActivePlan,
    required bool isWaitingListJoined,
  }) {
    if (hasPlan && !isAlreadyBooked && !isPast) return Colors.green;
    if (isFull && hasAnyActivePlan && !isWaitingListJoined) return Colors.orange;
    if (isFull && !hasAnyActivePlan) return Colors.grey;
    return Theme.of(context).colorScheme.primary;
  }

  bool isBookingDisabled({
    required bool isAlreadyBooked,
    required bool isBooking,
    required bool isPast,
    required bool isClosedDueToLowBookings,
    required bool isJoiningWaitingList,
    required bool isWaitingListJoined,
    required bool isCheckingPlan,
    required bool isFull,
    required bool hasAnyActivePlan,
  }) {
    return isAlreadyBooked ||
        isBooking ||
        isPast ||
        isClosedDueToLowBookings ||
        isJoiningWaitingList ||
        isWaitingListJoined ||
        isCheckingPlan ||
        (isFull && !hasAnyActivePlan);
  }

  String getSessionPlanText(
    SessionEntity session,
    bool hasPlan,
    int? sessionsUsed,
    int? sessionsTotal,
    String payableWithPlan,
  ) {
    if (hasPlan && sessionsUsed != null && sessionsTotal != null) {
      return '$sessionsUsed/$sessionsTotal sessions used';
    }
    if (hasPlan) return 'SAR ${session.service?.price ?? ''} • $payableWithPlan';
    return 'SAR ${session.service?.price ?? ''}';
  }

  String getSessionPriceText(
    SessionEntity session,
    bool hasPlan,
    int? sessionsUsed,
    int? sessionsTotal,
    String perSession,
  ) {
    if (hasPlan && sessionsUsed != null && sessionsTotal != null) {
      return '$sessionsUsed/$sessionsTotal sessions used';
    }
    return 'SAR ${session.service?.price?.toStringAsFixed(2) ?? ''} $perSession';
  }
}