import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/features/home/domain/use_cases/navigate_to_profile_screen_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/navigate_to_session_details_screen_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_states.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  late final SessionsViewModel viewModel;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SessionsViewModel>();
    viewModel.getAllSessions();
  }

  DateTime _normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  Map<DateTime, List<SessionEntity>> _buildEventsMap(
    List<SessionEntity> sessions,
  ) {
    final Map<DateTime, List<SessionEntity>> map = {};
    for (final session in sessions) {
      if (session.startTime == null) continue;
      final date = _normalize(DateTime.parse(session.startTime!).toLocal());
      map.putIfAbsent(date, () => []).add(session);
    }
    return map;
  }

  List<SessionEntity> _getEventsForDay(
    DateTime day,
    Map<DateTime, List<SessionEntity>> eventsMap,
  ) {
    return eventsMap[_normalize(day)] ?? [];
  }

  String _formatTime(String? isoString) {
    if (isoString == null) return '';
    final dt = DateTime.parse(isoString).toLocal();
    return DateFormat('h:mm a').format(dt);
  }

  String _formatDuration(String? start, String? end) {
    if (start == null || end == null) return '';
    final s = DateTime.parse(start);
    final e = DateTime.parse(end);
    final diff = e.difference(s).inMinutes;
    return '${diff}m';
  }

  String _formatDayLabel(DateTime day) {
    final now = DateTime.now();
    final normalized = _normalize(day);
    final todayNorm = _normalize(now);
    if (normalized == todayNorm) {
      return 'Today, ${DateFormat('EEEE, MMM d').format(day)}';
    }
    return DateFormat('EEEE, MMM d').format(day);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
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
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final sessions =
                state.getAllSessionsStateParams?.data?.sessions ?? [];
            final eventsMap = _buildEventsMap(sessions);
            final dayEvents = _getEventsForDay(_selectedDay, eventsMap);

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Calendar with dot markers on days that have sessions
                  AppCalendar(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    eventLoader: (day) => _getEventsForDay(day, eventsMap),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                  ),

                  // ✅ Filters row
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(color: AppColors.primary, height: 1),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Text(
                      _formatDayLabel(_selectedDay),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),

                  // ✅ Sessions list
                  Expanded(
                    child: dayEvents.isEmpty
                        ? Center(
                            child: Text(
                              'No sessions for this day',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14.sp,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: dayEvents.length,
                            separatorBuilder: (_, __) =>
                                Divider(color: AppColors.primary, height: 1),
                            itemBuilder: (context, index) {
                              return _buildSessionTile(dayEvents[index]);
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

  Widget _buildSessionTile(SessionEntity session) {
    final time = _formatTime(session.startTime);
    final duration = _formatDuration(session.startTime, session.endTime);
    final isBooked = session.status == 'booked';

    return InkWell(
      onTap: () {
        NavigateToSessionDetailsScreenUseCase.call(context, session.id!);
      },
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
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '($duration)',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
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
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'With ${session.staffMember?.name ?? ''}',
                    style: TextStyle(fontSize: 13.sp, color: AppColors.primary),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14.sp, color: AppColors.primary),
                      SizedBox(width: 4.w),
                      Text(
                        '${session.currentParticipants ?? 0}/${session.maxParticipants ?? 0}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primary,
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
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        session.service?.location ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                ),
                child: Text(
                  isBooked ? 'Info' : 'Book',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.person, size: 26, color: Colors.white),
        onPressed: () {
          NavigateToProfileScreenUseCase.call(context);
        },
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
