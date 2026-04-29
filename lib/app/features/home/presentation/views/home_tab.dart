import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/navigate_to_all_bookings_screen_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/home/domain/use_cases/navigate_to_profile_screen_use_case.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_events.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_view_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/navigate_to_session_details_screen_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final BookingsViewModel bookingsViewModel;

  @override
  void initState() {
    super.initState();
    bookingsViewModel = getIt<BookingsViewModel>();
    bookingsViewModel.getAllBookings();
  }

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    return BlocProvider.value(
      value: bookingsViewModel,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.artOfPilates,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeViewModel>().onEvent(
                              ChangeTabEvent(1),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            locale.bookNow,
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.upcomingBookins,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.accentColor,
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              NavigateToAllBookingsScreenUseCase.call(context),
                          child: Text(
                            locale.viewAll,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    BlocBuilder<BookingsViewModel, BookingsStates>(
                      builder: (context, state) {
                        if (state.getAllBookingsState?.isLoading ?? false) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state.getAllBookingsState?.errorMessage != null) {
                          return Center(
                            child: Text(
                              state.getAllBookingsState!.errorMessage!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 13.sp,
                              ),
                            ),
                          );
                        }

                        final bookings =
                            state.getAllBookingsState?.data?.bookings ?? [];

                        if (bookings.isEmpty) {
                          return _buildEmptyState(locale.noUpcomingBookings);
                        }

                        final now = DateTime.now();
                        final todayBookings = bookings.where((b) {
                          if (b.session?.status?.toUpperCase() != 'SCHEDULED') {
                            return false;
                          }
                          if (b.session?.startTime == null) return false;
                          final sessionDate = DateTime.parse(
                            b.session!.startTime!,
                          ).toLocal();
                          return sessionDate.year == now.year &&
                              sessionDate.month == now.month &&
                              sessionDate.day == now.day;
                        }).toList();

                        if (todayBookings.isEmpty) {
                          return _buildEmptyState(locale.noUpcomingBookings);
                        }

                        return Column(
                          children: todayBookings
                              .map((b) => _buildBookingCard(context, b))
                              .toList(),
                        );
                      },
                    ),

                    SizedBox(height: 24.h),
                    _buildSocialRow(context),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.accentColor,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, BookingEntity booking) {
    final session = booking.session;
    if (session == null) return const SizedBox.shrink();

    final startTime = session.startTime != null
        ? DateTime.parse(session.startTime!).toLocal()
        : null;
    final endTime = session.endTime != null
        ? DateTime.parse(session.endTime!).toLocal()
        : null;

    final day = startTime != null ? startTime.day.toString() : '';
    final month = startTime != null
        ? DateFormat('MMM').format(startTime).toUpperCase()
        : '';
    final formattedTime = startTime != null
        ? DateFormat('h:mm a').format(startTime)
        : '';
    final durationMinutes = startTime != null && endTime != null
        ? endTime.difference(startTime).inMinutes
        : 0;
    final isToday =
        startTime != null &&
        startTime.year == DateTime.now().year &&
        startTime.month == DateTime.now().month &&
        startTime.day == DateTime.now().day;

    return InkWell(
      onTap: () {
        NavigateToSessionDetailsScreenUseCase.call(context, session.id!);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  Text(
                    month,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.name ?? '',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${isToday ? appLocale(context).today : DateFormat('EEE').format(startTime!)}, $formattedTime ($durationMinutes min)',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.accentColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${session.staffMember?.name ?? ''}${session.service?.location != null ? ' · ${session.service!.location}' : ''}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_horiz,
                  color: AppColors.accentColor,
                  size: 20.sp,
                ),
                color: AppColors.whiteColor,
                onSelected: (value) async {
                  if (value == 'cancel') {
                    await context.read<BookingsViewModel>().cancelBooking(
                      booking.id,
                    );
                    if (context.mounted) {
                      await context.read<BookingsViewModel>().getAllBookings();
                    }
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'cancel',
                    child: Text(
                      appLocale(context).cancelBooking,
                      style: TextStyle(
                        color: AppColors.redColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialIcon(AppImages.instagramLogo, onTap: () {}),
        _buildSocialIcon(AppImages.whatsappLogo, onTap: () {}),
        _buildSocialIcon(AppImages.mapsLogo, onTap: () {}),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.accentColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              assetPath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.2,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.person, size: 26, color: Colors.white),
        onPressed: () => NavigateToProfileScreenUseCase.call(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, size: 26, color: Colors.white),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(AppImages.homeLogo, fit: BoxFit.cover),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
