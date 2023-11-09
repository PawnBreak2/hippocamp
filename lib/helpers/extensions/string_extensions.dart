import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String get svgPath => "assets/images/$this.svg";
  String get pngPath => "assets/images/$this.png";

  DateTime get dateFromString => DateFormat("yyyy-MM-dd").parse(this);

  Color get colorFromHex => Color(int.tryParse(replaceAll("#", "0xFF")) ?? 0);

  String get nameOfFile => substring(lastIndexOf("/") + 1);

  TimeOfDay get timeOfDayFromString {
    if (isEmpty || split(':').length < 2) return TimeOfDay.now();

    final hour = split(":")[0];
    final minute = split(":")[1];
    return TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
  }

  String get thousandsFormat {
    return NumberFormat.decimalPattern("it_IT")
        .format(double.tryParse(this) ?? 0);
  }
}
