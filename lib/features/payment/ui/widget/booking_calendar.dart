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
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2027, 12, 31),
        rangeStartDay: rangeStart,
        rangeEndDay: rangeEnd,
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        onRangeSelected: onSelect,
        calendarStyle: CalendarStyle(
          rangeStartDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.r),
          ),
          rangeHighlightColor: AppColors.primary.withOpacity(.2),

          rangeEndDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.r),
          ),

          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.r),
          ),

          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.r),
          ),

          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.r),
          ),

          defaultTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          weekendTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          todayTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
