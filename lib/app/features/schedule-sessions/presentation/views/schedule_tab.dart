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

            final sessions = state.getAllSessionsStateParams?.data?.sessions ?? [];
            
            // UI calls ViewModel for logic
            final eventsMap = viewModel.buildEventsMap(sessions);
            final dayEvents = viewModel.getEventsForDay(_selectedDay, eventsMap);

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCalendar(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    eventLoader: (day) => viewModel.getEventsForDay(day, eventsMap),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                  ),
                  
                  // Filters Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list, color: AppColors.primary, size: 20.sp),
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Text(
                      viewModel.formatDayLabel(_selectedDay),
                      style: TextStyle(color: AppColors.primary, fontSize: 13.sp),
                    ),
                  ),

                  Expanded(
                    child: dayEvents.isEmpty
                        ? Center(
                            child: Text(
                              'No sessions for this day',
                              style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
                            ),
                          )
                        : ListView.separated(
                            itemCount: dayEvents.length,
                            separatorBuilder: (_, _) => Divider(color: AppColors.primary, height: 1),
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
    // UI calls ViewModel for formatting
    final time = viewModel.formatTime(session.startTime);
    final duration = viewModel.formatDuration(session.startTime, session.endTime);
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
                        style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14.sp, color: AppColors.primary),
                      SizedBox(width: 4.w),
                      Text(
                        session.service?.location ?? '',
                        style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
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
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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