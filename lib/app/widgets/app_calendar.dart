import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final List<Object?> Function(DateTime) eventLoader;
  final void Function(DateTime, DateTime) onDaySelected;

  const AppCalendar({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.eventLoader,
    required this.onDaySelected,
  });

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          focusedDay: widget.focusedDay,
          selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
          calendarFormat: _calendarFormat,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week',
          },
          onFormatChanged: (format) {
            setState(() => _calendarFormat = format);
          },
          startingDayOfWeek: StartingDayOfWeek.saturday,
          onDaySelected: widget.onDaySelected,
          eventLoader: widget.eventLoader,
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            markerSize: 7.0,
            defaultTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            weekendTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            outsideTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Theme.of(context).primaryColor,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Theme.of(context).primaryColor,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Theme.of(context).primaryColor),
            weekendStyle: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _calendarFormat = _calendarFormat == CalendarFormat.week
                  ? CalendarFormat.month
                  : CalendarFormat.week;
            });
          },
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              setState(() => _calendarFormat = CalendarFormat.month);
            } else if (details.primaryVelocity! > 0) {
              setState(() => _calendarFormat = CalendarFormat.week);
            }
          },
          child: Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
      ],
    );
  }
}
