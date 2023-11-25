import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:collection/collection.dart';

class TimelineHelpers {
  static bool shouldShowTodayDivider(
      {required Post post,
      required Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth}) {
    final currentDate = DateTime.now();
    final currentMonth = currentDate.month;
    final currentYear = currentDate.year;
    final postsForCurrentMonth =
        postsMappedByYearAndMonth[currentYear]![currentMonth]!;

    if (postsForCurrentMonth.isEmpty) {
      return true;
    }

    final Post? firstPost = postsForCurrentMonth.firstWhereOrNull(
        (element) => element.date.dateFromString.isBefore(currentDate));

    if (post.key == firstPost?.key) {
      return true;
    } else {
      return false;
    }
  }

  static bool shouldShowTimeDivider(
      {required Post post,
      required Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth,
      required Map<String, List<Post>> postsMappedByDate}) {
    final currentDate = post.dateTimeFromString;
    final currentMonth = currentDate.month;
    final currentYear = currentDate.year;
    final postsForCurrentMonth =
        postsMappedByYearAndMonth[currentYear]![currentMonth]!;
    final List<Post> postsForCurrentDay = postsForCurrentMonth
        .where((element) =>
            element.dateTimeFromString.day == post.dateTimeFromString.day)
        .toList();
    // print('posts for current month');
    // print(postsForCurrentMonth);

    if (postsForCurrentDay[0].key == post.key) {
      return true;
    } else {
      return false;
    }
  }

  static int countTotalMonths(Map<int, Map<int, List<Post>>> postsByDate) {
    int totalMonths = 0;

    postsByDate.forEach((year, months) {
      totalMonths += months.length; // Add the number of months in this year
    });

    return totalMonths;
  }
}