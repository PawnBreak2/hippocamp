class DateHelpers {
  static String getTimeOfDay(String timeString) {
    // Split the string into hours, minutes, and seconds
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    // int minute = int.parse(parts[1]); // Minutes are not needed for this function

    // Determine time of day
    if (hour >= 5 && hour < 12) {
      return 'morning';
    } else if (hour >= 12 && hour < 17) {
      return 'afternoon';
    } else {
      return 'night';
    }
  }
}
