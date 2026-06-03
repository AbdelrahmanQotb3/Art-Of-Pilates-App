import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/copoun_sheet.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/widgets/app_exception_dialog.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_home_screen_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/navigate_to_session_checkout_screen_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_states.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_view_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/views/about_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionDetailsScreen extends StatefulWidget {
  final String sessionId;
  const SessionDetailsScreen({super.key, required this.sessionId});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  late final SessionsViewModel _sessionsViewModel;
  late final BookingsViewModel _bookingsViewModel;
  String _paymentOption = 'pay_now';
  String? _appliedCoupon;

  @override
  void initState() {
    super.initState();
    _sessionsViewModel = getIt<SessionsViewModel>();
    _bookingsViewModel = getIt<BookingsViewModel>();
    _sessionsViewModel.getOneSession(widget.sessionId);
    _bookingsViewModel.checkBooking(widget.sessionId);
    _bookingsViewModel.checkPlanForSession(widget.sessionId);
    _bookingsViewModel.getPlanSummery();
  }

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _sessionsViewModel),
        BlocProvider.value(value: _bookingsViewModel),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<BookingsViewModel, BookingsStates>(
            listenWhen: (prev, curr) =>
                prev.bookSessionState != curr.bookSessionState ||
                prev.appException != curr.appException,
            listener: (context, state) {
              if (state.appException != null &&
                  state.bookSessionState?.isLoading == false) {
                AppExceptionDialog.show(context, state.appException!);
                return;
              }
              if (state.bookSessionState?.isLoading == false &&
                  state.bookSessionState?.data != null) {
                _bookingsViewModel.checkBooking(widget.sessionId);
                _bookingsViewModel.getPlanSummery();
                _sessionsViewModel.getOneSession(widget.sessionId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(locale.sessionBookedSuccessfully),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              if (state.bookSessionState?.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.bookSessionState!.errorMessage!),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
          ),
          BlocListener<BookingsViewModel, BookingsStates>(
            listenWhen: (prev, curr) =>
                prev.joinWaitingListState != curr.joinWaitingListState,
            listener: (context, state) {
              if (state.joinWaitingListState?.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.joinWaitingListState!.errorMessage!),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: _buildAppBar(context, locale),
          body: BlocBuilder<SessionsViewModel, SessionsStates>(
            buildWhen: (prev, curr) =>
                prev.getOneSessionStateParams != curr.getOneSessionStateParams,
            builder: (context, state) {
              if (state.getOneSessionStateParams?.isLoading ?? false) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.getOneSessionStateParams?.errorMessage != null) {
                return _buildErrorState(context, locale);
              }
              final session = state.getOneSessionStateParams?.data;
              if (session == null) return const SizedBox.shrink();
              return _buildBody(context, session, locale);
            },
          ),
        ),
      ),
    );
  }
  PreferredSizeWidget _buildAppBar(BuildContext context, dynamic locale) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        locale.bookThisSession,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
  Widget _buildErrorState(BuildContext context, dynamic locale) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locale.someThingWentWrong,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onError,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () => _sessionsViewModel.getOneSession(widget.sessionId),
            child: Text(locale.retry),
          ),
        ],
      ),
    );
  }
  Widget _buildBody(
    BuildContext context,
    SessionEntity session,
    dynamic locale,
  ) {
    final isPast = _sessionsViewModel.isSessionPast(session);
    final spotsLeft = _sessionsViewModel.spotsLeft(session);
    final durationMinutes = _sessionsViewModel.sessionDurationMinutes(session);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 160.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageHeader(),
              _buildDetailsSection(session, durationMinutes, locale),
              _buildDivider(),
              _buildSection(
                child: AboutSection(description: session.service?.description ?? ''),
              ),
              _buildDivider(),
              _buildAvailabilitySection(session, spotsLeft, locale),
              _buildDivider(),
              _buildPriceSection(session, locale),
              _buildDivider(),
              _buildCouponSection(locale),
            ],
          ),
        ),
        _buildBookingFooter(context, session, isPast, locale),
      ],
    );
  }
  Widget _buildDetailsSection(
    SessionEntity session,
    int durationMinutes,
    dynamic locale,
  ) {
    return BlocBuilder<BookingsViewModel, BookingsStates>(
      buildWhen: (prev, curr) =>
          prev.getPlanSummeryState != curr.getPlanSummeryState,
      builder: (context, state) {
        final hasPlan = state.getPlanSummeryState?.data?.hasPlan ?? false;
        final sessionsUsed = state.getPlanSummeryState?.data?.sessionsUsed;
        final sessionsTotal = state.getPlanSummeryState?.data?.sessionsTotal;
        final planText = _sessionsViewModel.getSessionPlanText(
          session, hasPlan, sessionsUsed, sessionsTotal, locale.payableWithPlan,
        );

        return _buildSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.service?.name ?? '',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 12.h),
              _buildInfoRow(
                Icons.calendar_today_outlined,
                '${_sessionsViewModel.formatSessionDateTime(session)} ($durationMinutes min)',
              ),
              _buildInfoRow(Icons.monetization_on_outlined, planText),
              _buildInfoRow(Icons.person_outline, session.staffMember?.name ?? ''),
              _buildInfoRow(
                Icons.location_on_outlined,
                session.service?.location ?? '',
                underline: true,
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildAvailabilitySection(
    SessionEntity session,
    int spotsLeft,
    dynamic locale,
  ) {
    return _buildSection(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$spotsLeft ${locale.spotsLeft}',
            style: TextStyle(
              fontSize: 15.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(
            width: 32.w,
            height: 32.h,
            child: CircularProgressIndicator(
              value: _sessionsViewModel.sessionFillRatio(session),
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPriceSection(SessionEntity session, dynamic locale) {
    return BlocBuilder<BookingsViewModel, BookingsStates>(
      buildWhen: (prev, curr) =>
          prev.getPlanSummeryState != curr.getPlanSummeryState,
      builder: (context, state) {
        final hasPlan = state.getPlanSummeryState?.data?.hasPlan ?? false;
        final sessionsUsed = state.getPlanSummeryState?.data?.sessionsUsed;
        final sessionsTotal = state.getPlanSummeryState?.data?.sessionsTotal;
        final priceText = _sessionsViewModel.getSessionPriceText(
          session, hasPlan, sessionsUsed, sessionsTotal, locale.perSession,
        );

        return _buildSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.price.toUpperCase(),
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                priceText,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildCouponSection(dynamic locale) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          title: Text(
            _appliedCoupon ?? locale.enterCouponcode,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onTap: () => CouponBottomSheet.show(
            context,
            onApplied: (code) => setState(() => _appliedCoupon = code),
          ),
        ),
        _buildDivider(),
      ],
    );
  }
  Widget _buildBookingFooter(
    BuildContext context,
    SessionEntity session,
    bool isPast,
    dynamic locale,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        child: BlocBuilder<BookingsViewModel, BookingsStates>(
          buildWhen: (prev, curr) =>
              prev.checkBookingState != curr.checkBookingState ||
              prev.bookSessionState != curr.bookSessionState ||
              prev.joinWaitingListState != curr.joinWaitingListState ||
              prev.checkPlanState != curr.checkPlanState ||
              prev.getPlanSummeryState != curr.getPlanSummeryState,
          builder: (context, state) {
            final isChecking = state.checkBookingState?.isLoading ?? false;
            final isAlreadyBooked = state.checkBookingState?.data?.isBooked ?? false;
            final isBooking = state.bookSessionState?.isLoading ?? false;
            final isJoiningWaitingList = state.joinWaitingListState?.isLoading ?? false;
            final isWaitingListJoined = state.joinWaitingListState?.data != null;
            final isCheckingPlan = state.checkPlanState?.isLoading ?? false;
            final hasPlan = state.getPlanSummeryState?.data?.hasPlan ?? false;
            final hasAnyActivePlan = hasPlan;
            final isFull = _sessionsViewModel.isSessionFull(session);
            final userPlanId = state.checkPlanState?.data?.userPlanId;
            final planName = state.getPlanSummeryState?.data?.planName;
            final sessionsUsed = state.getPlanSummeryState?.data?.sessionsUsed ?? 0;
            final sessionsTotal = state.getPlanSummeryState?.data?.sessionsTotal ?? 0;
            final isClosedDueToLowBookings = _sessionsViewModel.isSessionClosedDueToLowBookings(session);

            if (isChecking || isCheckingPlan) {
              return const Center(child: CircularProgressIndicator());
            }
            final isDisabled = _sessionsViewModel.isBookingDisabled(
              isAlreadyBooked: isAlreadyBooked,
              isBooking: isBooking,
              isPast: isPast,
              isClosedDueToLowBookings: isClosedDueToLowBookings,
              isJoiningWaitingList: isJoiningWaitingList,
              isWaitingListJoined: isWaitingListJoined,
              isCheckingPlan: isCheckingPlan,
              isFull: isFull,
              hasAnyActivePlan: hasAnyActivePlan,
            );

            final statusText = _sessionsViewModel.getBookingStatusText(
              locale: locale,
              isAlreadyBooked: isAlreadyBooked,
              isPast: isPast,
              isClosedDueToLowBookings: isClosedDueToLowBookings,
              isFull: isFull,
              isWaitingListJoined: isWaitingListJoined,
              hasPlan: hasPlan,
              hasAnyActivePlan: hasAnyActivePlan,
              planName: planName,
              sessionsUsed: sessionsUsed,
              sessionsTotal: sessionsTotal,
              paymentOption: _paymentOption,
              session: session,
            );

            final buttonLabel = _sessionsViewModel.getBookingButtonLabel(
              locale: locale,
              isAlreadyBooked: isAlreadyBooked,
              isPast: isPast,
              isFull: isFull,
              isWaitingListJoined: isWaitingListJoined,
              hasPlan: hasPlan,
              hasAnyActivePlan: hasAnyActivePlan,
              paymentOption: _paymentOption,
            );

            final buttonColor = _sessionsViewModel.getButtonColor(
              context: context,
              hasPlan: hasPlan,
              isAlreadyBooked: isAlreadyBooked,
              isPast: isPast,
              isFull: isFull,
              hasAnyActivePlan: hasAnyActivePlan,
              isWaitingListJoined: isWaitingListJoined,
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: buttonColor.withOpacity(
                      isAlreadyBooked || isPast ? 1.0 : 0.85,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: isDisabled
                        ? null
                        : () => _handleBookingAction(
                              context: context,
                              session: session,
                              isFull: isFull,
                              hasPlan: hasPlan,
                              hasAnyActivePlan: hasAnyActivePlan,
                              userPlanId: userPlanId,
                              locale: locale,
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      disabledBackgroundColor:
                          Theme.of(context).colorScheme.primary.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: isBooking || isJoiningWaitingList
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            buttonLabel,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 10.h),
                if (!isPast && !isFull && !hasPlan)
                  GestureDetector(
                    onTap: () => _showPaymentOptionsSheet(context, locale),
                    child: Text(
                      locale.viewPaymentOptions,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
  Future<void> _handleBookingAction({
    required BuildContext context,
    required SessionEntity session,
    required bool isFull,
    required bool hasPlan,
    required bool hasAnyActivePlan,
    required String? userPlanId,
    required dynamic locale,
  }) async {
    if (isFull) {
      if (!hasAnyActivePlan) return;
      final result = await _bookingsViewModel.joinWaitingList(widget.sessionId);
      if (!context.mounted) return;
      switch (result) {
        case SuccessResponse():
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You've joined the waiting list!"),
            backgroundColor: Colors.orange,
          ));
        case ErrorResponse(:final error):
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
      }
      return;
    }
    if (hasPlan && userPlanId != null) {
      final result = await _bookingsViewModel.bookSessionWithPlan(
        sessionId: widget.sessionId,
        userPlanId: userPlanId,
      );
      if (!context.mounted) return;
      switch (result) {
        case SuccessResponse():
          _bookingsViewModel.checkBooking(widget.sessionId);
          _bookingsViewModel.getPlanSummery();
          _sessionsViewModel.getOneSession(widget.sessionId);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Session booked with your plan!'),
            backgroundColor: Colors.green,
          ));
        case ErrorResponse(:final error):
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
      }
      return;
    }
    if (_paymentOption == 'pay_now') {
      NavigateToSessionCheckoutScreenUseCase.call(context, session);
    } else if (_paymentOption == 'buy_plan') {
      NavigateToHomeScreenUseCase.call(context, initialTabIndex: 2);
    }
  }
  void _showPaymentOptionsSheet(BuildContext context, dynamic locale) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            ListTile(
              title: Text(locale.viewPaymentOptions,
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            _buildDivider(),
            _buildPaymentOptionTile(
              context: context,
              setSheetState: setSheetState,
              label: locale.buyAPlan,
              value: 'buy_plan',
            ),
            _buildPaymentOptionTile(
              context: context,
              setSheetState: setSheetState,
              label: locale.payNow,
              value: 'pay_now',
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptionTile({
    required BuildContext context,
    required StateSetter setSheetState,
    required String label,
    required String value,
  }) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: _paymentOption == value
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.onSurface)
          : null,
      onTap: () {
        setState(() => _paymentOption = value);
        setSheetState(() {});
        Navigator.pop(context);
      },
    );
  }
  Widget _buildSection({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: child,
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Theme.of(context).colorScheme.onSurface,
      height: 1,
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool underline = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: Theme.of(context).colorScheme.onSurface),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).colorScheme.onSurface,
                decoration: underline ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader() => Image.asset(
        AppImages.homeLogo,
        width: double.infinity,
        height: 120.h,
        fit: BoxFit.cover,
      );
}