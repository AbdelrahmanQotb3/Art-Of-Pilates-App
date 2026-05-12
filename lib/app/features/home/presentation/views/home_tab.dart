import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/navigate_to_all_bookings_screen_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/home/domain/use_cases/navigate_to_profile_screen_use_case.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_events.dart';
import 'package:art_of_pilates/app/features/home/presentation/view_model/home_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_exception_dialog.dart';
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
  late final HomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    bookingsViewModel = getIt<BookingsViewModel>();
    homeViewModel = getIt<HomeViewModel>();
    bookingsViewModel.getAllBookings();
  }

  Future<void> _launchSocial(BuildContext context, String url) async {
    try {
      await context.read<HomeViewModel>().launchSocialUrl(url);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not open link')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: bookingsViewModel,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
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
                          style: theme.textTheme.headlineSmall,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeViewModel>().onEvent(
                              ChangeTabEvent(1),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text(locale.bookNow),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.upcomingBookins,
                          style: theme.textTheme.titleMedium,
                        ),
                        InkWell(
                          onTap: () =>
                              NavigateToAllBookingsScreenUseCase.call(context),
                          child: Text(
                            locale.viewAll,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
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
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                          );
                        }
                        final bookings =
                            state.getAllBookingsState?.data?.bookings ?? [];
                        if (bookings.isEmpty) {
                          return _buildEmptyState(
                            locale.noUpcomingBookings,
                            theme,
                          );
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
                          return _buildEmptyState(
                            locale.noUpcomingBookings,
                            theme,
                          );
                        }
                        return Column(
                          children: todayBookings
                              .map((b) => _buildBookingCard(context, b, theme))
                              .toList(),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    _buildSocialRow(context, theme),
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

  Widget _buildEmptyState(String message, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Center(child: Text(message, style: theme.textTheme.bodyMedium)),
    );
  }

  Widget _buildBookingCard(
    BuildContext context,
    BookingEntity booking,
    ThemeData theme,
  ) {
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
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor,
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
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 22.sp,
                    ),
                  ),
                  Text(
                    month,
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
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
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${isToday ? appLocale(context).today : DateFormat('EEE').format(startTime!)}, $formattedTime ($durationMinutes min)',
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${session.staffMember?.name ?? ''}${session.service?.location != null ? ' · ${session.service!.location}' : ''}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_horiz,
                  color: theme.colorScheme.onSurface,
                  size: 20.sp,
                ),
                color: theme.colorScheme.surface,
                onSelected: (value) async {
                  if (value == 'cancel') {
                    final result = await context
                        .read<BookingsViewModel>()
                        .cancelBooking(booking.id);

                    switch (result) {
                      case ErrorResponse(:final error):
                        if (context.mounted) {
                          if (error is AppException) {
                            await AppExceptionDialog.show(context, error);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())),
                            );
                          }
                        }
                      case SuccessResponse():
                        break;
                    }

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
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
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

  Widget _buildSocialRow(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialIcon(
          AppImages.instagramLogo,
          theme,
          onTap: () => _launchSocial(context, homeViewModel.instagramUrl),
        ),
        _buildSocialIcon(
          AppImages.whatsappLogo,
          theme,
          onTap: () => _launchSocial(context, homeViewModel.whatsappUrl),
        ),
        _buildSocialIcon(
          AppImages.mapsLogo,
          theme,
          onTap: () => _launchSocial(context, homeViewModel.mapsUrl),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(
    String assetPath,
    ThemeData theme, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 45.w,
            height: 45.h,
            fit: BoxFit.contain,
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
      backgroundColor: Theme.of(context).colorScheme.primary,
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
