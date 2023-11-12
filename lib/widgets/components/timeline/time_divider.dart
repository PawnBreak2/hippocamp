import 'package:flutter/material.dart';
import 'package:hippocamp/helpers/extensions/int_extensions.dart';
import 'package:hippocamp/styles/colors.dart';

class TimelineTimeDivider extends StatelessWidget {
  late DateTime date;
  bool isToday = false;
  TimelineTimeDivider({
    Key? key,
    required this.date,
    required this.isToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = date.weekday.dayFromInt.substring(0, 3).toUpperCase();
    final month = date.month.monthFromInt.substring(0, 3).toUpperCase();
    final dayNumber = date.day;
    final isPast = date.isBefore(DateTime.now());
    return Container(
      color: isToday
          ? CustomColors.primaryLightBlue
          : isPast
              ? Colors.white
              : CustomColors.primaryLightBlue,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: .5,
              color: CustomColors.darkGrey,
              margin: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
          Text(
            "$day $dayNumber $month".toLowerCase(),
            style: TextStyle(
              color: CustomColors.blue,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Container(
              height: .5,
              color: CustomColors.darkGrey,
              margin: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }
}
