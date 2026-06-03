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
          daysOfWeekHeight: 26.h,
          selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
          calendarFormat: _calendarFormat,
          availableCalendarFormats: const {CalendarFormat.week: 'Week'},
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
              _calendarFormat = CalendarFormat.week;
            });
          }, // removed on vertical drag to prevent conflict with ListView inside calendar
          child: SizedBox(height: 10.h),
        ),
      ],
    );
  }
}
