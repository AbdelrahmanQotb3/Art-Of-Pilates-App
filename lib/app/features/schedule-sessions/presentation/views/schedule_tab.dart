import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/home/domain/use_cases/navigate_to_profile_screen_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/navigate_to_session_details_screen_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_states.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  late final SessionsViewModel viewModel;
  late final BookingsViewModel bookingsViewModel;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SessionsViewModel>();
    bookingsViewModel = getIt<BookingsViewModel>();
    viewModel.getAllSessions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: viewModel),
        BlocProvider.value(value: bookingsViewModel),
      ],
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: _buildAppBar(context),
        body: BlocBuilder<SessionsViewModel, SessionsStates>(
          builder: (context, state) {
            if (state.getAllSessionsStateParams?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.getAllSessionsStateParams?.errorMessage != null) {
              return Center(
                child: Text(
                  'Error: ${state.getAllSessionsStateParams!.errorMessage}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              );
            }

            final sessions =
                state.getAllSessionsStateParams?.data?.sessions ?? [];

            if (sessions.isNotEmpty) {
              final ids = sessions
                  .where((s) => s.id != null)
                  .map((s) => s.id!)
                  .toList();
              bookingsViewModel.checkAllSessions(ids);
            }

            final eventsMap = viewModel.buildEventsMap(sessions);
            final dayEvents = viewModel.getEventsForDay(
              _selectedDay,
              eventsMap,
            );

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCalendar(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    eventLoader: (day) =>
                        viewModel.getEventsForDay(day, eventsMap),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: theme.colorScheme.primary,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Filters',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: theme.colorScheme.primary, height: 1),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Text(
                      viewModel.formatDayLabel(_selectedDay),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: dayEvents.isEmpty
                        ? Center(
                            child: Text(
                              'No sessions for this day',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: dayEvents.length,
                            separatorBuilder: (_, _) => Divider(
                              color: theme.colorScheme.primary,
                              height: 1,
                            ),
                            itemBuilder: (context, index) {
                              return _buildSessionTile(
                                context,
                                dayEvents[index],
                                theme,
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSessionTile(
    BuildContext context,
    SessionEntity session,
    ThemeData theme,
  ) {
    final time = viewModel.formatTime(session.startTime);
    final duration = viewModel.formatDuration(
      session.startTime,
      session.endTime,
    );
    final isFull =
        (session.currentParticipants ?? 0) >= (session.maxParticipants ?? 0);

    return InkWell(
      onTap: () =>
          NavigateToSessionDetailsScreenUseCase.call(context, session.id!),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    '($duration)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.name ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'With ${session.staffMember?.name ?? ''}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 14.sp,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${session.currentParticipants ?? 0}/${session.maxParticipants ?? 0}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14.sp,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        session.service?.location ?? '',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<BookingsViewModel, BookingsStates>(
              buildWhen: (prev, curr) =>
                  prev.checkedSessions != curr.checkedSessions,
              builder: (context, bookingState) {
                final isBooked =
                    bookingState.checkedSessions[session.id] ?? false;

                final String label;
                final Color bgColor;

                if (isFull) {
                  label = appLocale(context).full;
                  bgColor = theme.colorScheme.primary;
                } else if (isBooked) {
                  label = appLocale(context).booked;
                  bgColor = Colors.green.shade700;
                } else {
                  label = appLocale(context).book;
                  bgColor = theme.colorScheme.primary;
                }

                return Align(
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    onPressed: isFull || isBooked
                        ? null
                        : () => NavigateToSessionDetailsScreenUseCase.call(
                            context,
                            session.id!,
                          ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: bgColor),
                      backgroundColor: bgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                    ),
                    child: Text(
                      label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}
