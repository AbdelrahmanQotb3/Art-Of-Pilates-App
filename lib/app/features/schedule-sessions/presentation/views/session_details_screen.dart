import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/copoun_sheet.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
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
      backgroundColor: AppColors.backgroundColor,
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
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                ListTile(
                  title: Text(
                    locale.viewPaymentOptions,
                    style: TextStyle(fontSize: 15.sp, color: AppColors.accentColor),
                  ),
                ),
                Divider(color: AppColors.accentColor, height: 1),
                ListTile(
                  title: Text(
                    locale.buyAPlan,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  trailing: _paymentOption == 'buy_plan'
                      ? Icon(Icons.check, color: AppColors.accentColor)
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
                      color: AppColors.accentColor,
                    ),
                  ),
                  trailing: _paymentOption == 'pay_now'
                      ? Icon(Icons.check, color: AppColors.accentColor)
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
            prev.bookSessionState != curr.bookSessionState,
        listener: (context, state) {
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
                backgroundColor: AppColors.redColor,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
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
                        'Something went wrong',
                        style: TextStyle(
                          color: AppColors.whiteColor,
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
      backgroundColor: AppColors.primary,
      title: Text(
        locale.bookThisSession,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SessionEntity session) {
    final locale = appLocale(context);
    final spotsLeft =
        (session.maxParticipants ?? 0) - (session.currentParticipants ?? 0);
    final durationMinutes =
        session.startTime != null && session.endTime != null
            ? DateTime.parse(session.endTime!)
                .difference(DateTime.parse(session.startTime!))
                .inMinutes
            : 0;
    final formattedTime = session.startTime != null
        ? DateFormat('h:mm a')
            .format(DateTime.parse(session.startTime!).toLocal())
        : '';

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
                        color: AppColors.accentColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildInfoRow(
                      Icons.calendar_today_outlined,
                      'Today, $formattedTime ($durationMinutes minutes)',
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
              Divider(color: AppColors.accentColor, height: 1),
              _buildSection(
                child: AboutSection(
                  description: session.service?.description ?? '',
                ),
              ),
              Divider(color: AppColors.accentColor, height: 1),
              _buildSection(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$spotsLeft ${locale.spotsLeft}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.accentColor,
                      ),
                    ),
                    SizedBox(
                      width: 32.w,
                      height: 32.h,
                      child: CircularProgressIndicator(
                        value: session.maxParticipants != null &&
                                session.maxParticipants! > 0
                            ? (session.currentParticipants ?? 0) /
                                session.maxParticipants!
                            : 0,
                        backgroundColor: AppColors.accentColor,
                        color: AppColors.primary,
                        strokeWidth: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.accentColor, height: 1),
              _buildSection(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.price.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.accentColor,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'SAR ${session.service?.price?.toStringAsFixed(2) ?? ''} per session',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.accentColor, height: 1),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                title: Text(
                  _appliedCoupon ?? locale.enterCouponcode,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.accentColor,
                  ),
                ),
                trailing:
                    Icon(Icons.chevron_right, color: AppColors.accentColor),
                onTap: () {
                  CouponBottomSheet.show(context, onApplied: (code) {
                    setState(() => _appliedCoupon = code);
                  });
                },
              ),
              Divider(color: AppColors.accentColor, height: 1),
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: AppColors.backgroundColor,
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

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isAlreadyBooked
                          ? locale.alreadyBooked
                          : (_paymentOption == 'buy_plan'
                              ? locale.buyAPlanToBookThisSession
                              : 'SAR ${session.service?.price ?? ''} ${locale.dueNow}'),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.accentColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: isAlreadyBooked || isBooking
                            ? null
                            : () {
                                if (_paymentOption == 'pay_now') {
                                  bookingsViewModel.bookSession(session.id!);
                                } else {
                                  NavigateToSessionCheckoutScreenUseCase.call(
                                    context,
                                    session,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAlreadyBooked
                              // ignore: deprecated_member_use
                              ? AppColors.primary.withOpacity(0.4)
                              : AppColors.primary,
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
                                isAlreadyBooked
                                    ? locale.booked
                                    : (_paymentOption == 'buy_plan'
                                        ? locale.buyPlan
                                        : locale.bookAndPay),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () => _showPaymentOptionsSheet(context),
                      child: Text(
                        locale.viewPaymentOptions,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary,
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
          Icon(icon, size: 16.sp, color: AppColors.accentColor),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.accentColor,
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