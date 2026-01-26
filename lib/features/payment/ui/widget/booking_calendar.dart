import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final Function(DateTime?, DateTime?, DateTime) onSelect;

  const BookingCalendar({
    super.key,
    required this.focusedDay,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.calenderColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(2025, 1, 1),
        lastDay: DateTime(2027, 12, 31),
        rangeStartDay: rangeStart,
        rangeEndDay: rangeEnd,

        rangeSelectionMode: RangeSelectionMode.toggledOn,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        onRangeSelected: onSelect,
        calendarStyle: CalendarStyle(
          rangeStartDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          rangeHighlightColor: Colors.transparent,
          rangeEndDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(color: Colors.black),
          todayDecoration: const BoxDecoration(color: Colors.transparent),
        ),
      ),
    );
  }
}
