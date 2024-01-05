import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
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
      print('true!!!');
      print(post.date.dateFromString);
      return true;
    } else {
      print(currentMonth);
      print(currentYear);
      print(post.key);
      print(firstPost?.key);
      print('returninf false');
      return false;
    }
  }

  static bool shouldShowTimeDivider({
    required Post post,
    required Map<int, Map<int, List<Post>>> postsMappedByYearAndMonth,
  }) {
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

  static int countTotalPosts(Map<int, Map<int, List<Post>>> postsByDate) {
    int totalPosts = 0;

    postsByDate.forEach((year, months) {
      months.forEach((month, postsList) {
        totalPosts += postsList.length; // Add the number of posts in this month
      });
    });

    return totalPosts;
  }
}
