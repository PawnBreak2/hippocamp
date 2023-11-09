import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  String get dateToString =>
      "$year-${"$month".padLeft(2, "0")}-${"$day".padLeft(2, "0")}";

  String get dateToStringWithoutDay => "$year-${"$month".padLeft(2, "0")}";
}

extension TimeOfDayExtension on TimeOfDay {
  String get timeToString =>
      "${"$hour".padLeft(2, "0")}:${"$minute".padLeft(2, "0")}";
}
