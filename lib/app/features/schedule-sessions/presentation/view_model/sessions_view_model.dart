import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/get_all_sessions_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/get_one_session_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class SessionsViewModel extends Cubit<SessionsStates> {
  final GetAllSessionsUseCase getAllSessionsUseCase;
  final GetOneSessionUseCase getOneSessionUseCase;
  
  SessionsViewModel(this.getAllSessionsUseCase, this.getOneSessionUseCase) : super(SessionsStates());

  Future<BaseResponse<SessionsModel>> getAllSessions() async {
    emit(state.copyWith(getAllSessionsStateParams: BaseState<SessionsModel>(isLoading: true)));
    final response = await getAllSessionsUseCase.call();
    switch (response) {
      case SuccessResponse<SessionsModel>():
        emit(state.copyWith(getAllSessionsStateParams: BaseState<SessionsModel>(data: response.data, isLoading: false)));
        return response;
      case ErrorResponse<SessionsModel>():
        emit(state.copyWith(getAllSessionsStateParams: BaseState<SessionsModel>(errorMessage: response.error.toString(), isLoading: false)));
        return response;
    }
  }


  DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  Map<DateTime, List<SessionEntity>> buildEventsMap(List<SessionEntity> sessions) {
    final Map<DateTime, List<SessionEntity>> map = {};
    for (final session in sessions) {
      if (session.startTime == null) continue;
      final date = normalize(DateTime.parse(session.startTime!).toLocal());
      map.putIfAbsent(date, () => []).add(session);
    }
    return map;
  }

  List<SessionEntity> getEventsForDay(DateTime day, Map<DateTime, List<SessionEntity>> eventsMap) {
    return eventsMap[normalize(day)] ?? [];
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

  String formatDayLabel(DateTime day) {
    final now = DateTime.now();
    final normalized = normalize(day);
    final todayNorm = normalize(now);
    if (normalized == todayNorm) {
      return 'Today, ${DateFormat('EEEE, MMM d').format(day)}';
    }
    return DateFormat('EEEE, MMM d').format(day);
  }

  Future<BaseResponse<SessionEntity>> getOneSession(String id) async {
    emit(state.copyWith(getOneSessionStateParams: BaseState<SessionEntity>(isLoading: true)));
    final response = await getOneSessionUseCase.call(id);
    switch (response) {
      case SuccessResponse<SessionEntity>():
        emit(state.copyWith(getOneSessionStateParams: BaseState<SessionEntity>(data: response.data, isLoading: false)));
        return response;
      case ErrorResponse<SessionEntity>():
        emit(state.copyWith(getOneSessionStateParams: BaseState<SessionEntity>(errorMessage: response.error.toString(), isLoading: false)));
        return response;
    }
  }
}