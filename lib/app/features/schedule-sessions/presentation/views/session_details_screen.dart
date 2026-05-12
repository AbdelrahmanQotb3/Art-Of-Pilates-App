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
import 'package:intl/intl.dart';

class SessionDetailsScreen extends StatefulWidget {
  final String sessionId;
  const SessionDetailsScreen({super.key, required this.sessionId});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  late final SessionsViewModel viewModel;
  late final BookingsViewModel bookingsViewModel;
  String _paymentOption = 'pay_now';
  String? _appliedCoupon;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SessionsViewModel>();
    bookingsViewModel = getIt<BookingsViewModel>();
    viewModel.getOneSession(widget.sessionId);
    bookingsViewModel.checkBooking(widget.sessionId);
  }

  void _showPaymentOptionsSheet(BuildContext context) {
    final locale = appLocale(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Column(
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
                  title: Text(
                    locale.viewPaymentOptions,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 1),
                ListTile(
                  title: Text(
                    locale.buyAPlan,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  trailing: _paymentOption == 'buy_plan'
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.onSurface,
                        )
                      : null,
                  onTap: () {
                    setState(() => _paymentOption = 'buy_plan');
                    setSheetState(() {});
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    locale.payNow,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  trailing: _paymentOption == 'pay_now'
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.onSurface,
                        )
                      : null,
                  onTap: () {
                    setState(() => _paymentOption = 'pay_now');
                    setSheetState(() {});
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 16.h),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: viewModel),
        BlocProvider.value(value: bookingsViewModel),
      ],
      child: BlocListener<BookingsViewModel, BookingsStates>(
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
            bookingsViewModel.checkBooking(widget.sessionId);
            viewModel.getOneSession(widget.sessionId);
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
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: _buildAppBar(context),
          body: BlocBuilder<SessionsViewModel, SessionsStates>(
            buildWhen: (prev, curr) =>
                prev.getOneSessionStateParams != curr.getOneSessionStateParams,
            builder: (context, state) {
              if (state.getOneSessionStateParams?.isLoading ?? false) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.getOneSessionStateParams?.errorMessage != null) {
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
                        onPressed: () =>
                            viewModel.getOneSession(widget.sessionId),
                        child: Text(locale.retry),
                      ),
                    ],
                  ),
                );
              }
              final session = state.getOneSessionStateParams?.data;
              if (session == null) return const SizedBox.shrink();
              return _buildBody(context, session);
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
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

  Widget _buildBody(BuildContext context, SessionEntity session) {
    final locale = appLocale(context);

    final isPast = session.startTime != null
        ? DateTime.parse(session.startTime!).toLocal().isBefore(DateTime.now())
        : false;

    final spotsLeft =
        (session.maxParticipants ?? 0) - (session.currentParticipants ?? 0);
    final durationMinutes = session.startTime != null && session.endTime != null
        ? DateTime.parse(
            session.endTime!,
          ).difference(DateTime.parse(session.startTime!)).inMinutes
        : 0;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 160.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageHeader(),
              _buildSection(
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
                      session.startTime != null
                          ? '${DateFormat('d MMM yyyy, h:mm a').format(DateTime.parse(session.startTime!).toLocal())} ($durationMinutes min)'
                          : '',
                    ),
                    _buildInfoRow(
                      Icons.monetization_on_outlined,
                      'SAR ${session.service?.price ?? ''} • Payable with plan',
                    ),
                    _buildInfoRow(
                      Icons.person_outline,
                      session.staffMember?.name ?? '',
                    ),
                    _buildInfoRow(
                      Icons.location_on_outlined,
                      session.service?.location ?? '',
                      underline: true,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                height: 1,
              ),
              _buildSection(
                child: AboutSection(
                  description: session.service?.description ?? '',
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                height: 1,
              ),
              _buildSection(
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
                        value:
                            session.maxParticipants != null &&
                                session.maxParticipants! > 0
                            ? (session.currentParticipants ?? 0) /
                                  session.maxParticipants!
                            : 0,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface,
                        color: Theme.of(context).colorScheme.primary,
                        strokeWidth: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                height: 1,
              ),
              _buildSection(
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
                      'SAR ${session.service?.price?.toStringAsFixed(2) ?? ''} ${locale.perSession}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                height: 1,
              ),
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
                onTap: () {
                  CouponBottomSheet.show(
                    context,
                    onApplied: (code) {
                      setState(() => _appliedCoupon = code);
                    },
                  );
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface,
                height: 1,
              ),
            ],
          ),
        ),

        // Bottom booking bar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            child: BlocBuilder<BookingsViewModel, BookingsStates>(
              buildWhen: (prev, curr) =>
                  prev.checkBookingState != curr.checkBookingState ||
                  prev.bookSessionState != curr.bookSessionState,
              builder: (context, bookingState) {
                final isChecking =
                    bookingState.checkBookingState?.isLoading ?? false;
                final isAlreadyBooked =
                    bookingState.checkBookingState?.data?.isBooked ?? false;
                final isBooking =
                    bookingState.bookSessionState?.isLoading ?? false;

                if (isChecking) {
                  return const Center(child: CircularProgressIndicator());
                }

                final String statusText;
                if (isAlreadyBooked) {
                  statusText = locale.alreadyBooked;
                } else if (isPast) {
                  statusText = locale.thisSessionHasEnded;
                } else if (_paymentOption == 'buy_plan') {
                  statusText = locale.buyAPlanToBookThisSession;
                } else {
                  statusText =
                      'SAR ${session.service?.price ?? ''} ${locale.dueNow}';
                }

                // Determine button label
                final String buttonLabel;
                if (isAlreadyBooked) {
                  buttonLabel = locale.booked;
                } else if (isPast) {
                  buttonLabel = locale.sessionEnded;
                } else if (_paymentOption == 'buy_plan') {
                  buttonLabel = locale.buyPlan;
                } else {
                  buttonLabel = locale.bookAndPay;
                }

                final bool isDisabled = isAlreadyBooked || isBooking || isPast;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isPast
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.onSurface,
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
                            : () {
                                if (_paymentOption == 'pay_now') {
                                  NavigateToSessionCheckoutScreenUseCase.call(
                                    context,
                                    session,
                                  );
                                } else if (_paymentOption == 'buy_plan') {
                                  NavigateToHomeScreenUseCase.call(
                                    context,
                                    initialTabIndex: 2,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          disabledBackgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: isBooking
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
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Only show payment options if session is not past
                    if (!isPast)
                      GestureDetector(
                        onTap: () => _showPaymentOptionsSheet(context),
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
        ),
      ],
    );
  }

  Widget _buildSection({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: child,
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool underline = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).colorScheme.onSurface,
              decoration: underline ? TextDecoration.underline : null,
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
