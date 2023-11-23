import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/helpers/extensions/datetime_extension.dart';
import 'package:hippocamp/helpers/extensions/int_extensions.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/wallets_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/components/time_event_item.dart';
import 'package:hippocamp/widgets/components/timeline/month_divider.dart';
import 'package:hippocamp/widgets/components/timeline/no_posts_in_timeline.dart';
import 'package:hippocamp/widgets/components/timeline/year_divider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:collection/collection.dart';

class TimelinePage extends ConsumerStatefulWidget {
  final bool isSearching;
  const TimelinePage({required this.isSearching});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  // used to avoid the repetition of the call to the getFirstPostOfTheYear function saving resources
  bool gotFirstPostOfYear = false;

  // used to check the previous year of post rendered and activate dividers accordingly
  String previousYearInTimeLinePost = '';
  int indexForMonths = 0;
  bool _isLoading = true;
  bool _getNewPosts = false;
  bool _showCenterButton = false;
  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;

  Widget _timeDivider({
    required DateTime date,
    bool isToday = false,
  }) {
    final day = date.weekday.dayFromInt.substring(0, 3).toUpperCase();
    final month = date.month.monthFromInt.substring(0, 3).toUpperCase();
    final dayNumber = date.day;
    final isPast = date.isBefore(DateTime.now());

    return Container(
      color: isToday
          ? Color.fromRGBO(241, 245, 223, 1)
          : isPast
              ? Colors.white
              : CustomColors.primaryLightBlue,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: .5,
              color: const Color.fromARGB(255, 100, 100, 100),
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
              color: const Color.fromARGB(255, 100, 100, 100),
              margin: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    super.initState();
    _init().whenComplete(() async {
      print('value to scroll to');
      print(ref.read(appStateProvider).valueToScrollToToday);
      await Future.delayed(Duration(milliseconds: 5000));

      final appStateProviderState = ref.read(appStateProvider);
      itemScrollController.scrollTo(
        index: appStateProviderState.valueToScrollToToday,
        duration: Duration(milliseconds: 1),
      );

      itemPositionsListener.itemPositions.addListener(checkScrolling);
    });
  }

  Future<void> _init() async {
    final postsProviderState = ref.read(postListProvider);
    final postsProviderNotifier = ref.read(postListProvider.notifier);
    final appStateProviderNotifier = ref.read(appStateProvider.notifier);
    final walletsProviderNotifier = ref.read(walletsProvider.notifier);
    if (postsProviderState.allPosts.isEmpty) {
      await postsProviderNotifier.getPosts();
      await appStateProviderNotifier.getAttachmentTypes();
      await walletsProviderNotifier.getWallets();

      _isLoading = false;
      setState(() {});
    } else
      _isLoading = false;
  }

  void checkScrolling() async {
    //print(itemPositionsListener.itemPositions.value);
    final postsProviderNotifier = ref.read(postListProvider.notifier);
    final postsProviderState = ref.read(postListProvider);
    final appStateProviderState = ref.read(appStateProvider);
    final nearTheStart =
        itemPositionsListener.itemPositions.value.first.index < 3;

    final nearTheEnd = itemPositionsListener.itemPositions.value.last.index ==
        (postsProviderState.postsMappedByDate.length - 1);

    final listIndexesVisible =
        itemPositionsListener.itemPositions.value.map((e) => e.index);
    final showScrollToToday = !listIndexesVisible
        .contains(appStateProviderState.valueToScrollToToday);

    if (showScrollToToday && !_showCenterButton) {
      _showCenterButton = true;
      setState(() {});
    } else if (!showScrollToToday && _showCenterButton) {
      _showCenterButton = false;
      setState(() {});
    }

    if (widget.isSearching) return;

    if (nearTheStart && !postsProviderNotifier.endFutureList) {
      if (_getNewPosts) return;

      _getNewPosts = true;
      //await postsProviderNotifier.getNewPosts(past: false);
      _getNewPosts = false;
    }

    if (nearTheEnd && !postsProviderNotifier.endList) {
      if (_getNewPosts) return;

      _getNewPosts = true;
      //await postsProviderNotifier.getNewPosts(past: true);
      _getNewPosts = false;
    }
  }

  int countTotalMonths(Map<int, Map<int, List<Post>>> postsByDate) {
    int totalMonths = 0;

    postsByDate.forEach((year, months) {
      totalMonths += months.length; // Add the number of months in this year
    });

    return totalMonths;
  }

  bool shouldShowTodayDivider(Post post) {
    final postsProviderState = ref.watch(postListProvider);
    final postsMappedByYearAndMonth =
        postsProviderState.postsMappedByYearAndMonth;

    final currentDate = DateTime.now();
    final currentMonth = currentDate.month;
    final currentYear = currentDate.year;
    final postsForCurrentMonth =
        postsMappedByYearAndMonth[currentYear]![currentMonth]!;

    if (postsForCurrentMonth.isEmpty) {
      return true;
    }

    final Post? postBeforeToday = postsForCurrentMonth.firstWhereOrNull(
        (element) => element.date.dateFromString.isBefore(currentDate));

    if (post.key == postBeforeToday?.key) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowTimeDivider(Post post) {
    final postsProviderState = ref.watch(postListProvider);
    final postsMappedByYearAndMonth =
        postsProviderState.postsMappedByYearAndMonth;

    final currentDate = DateTime.now();
    final currentMonth = currentDate.month;
    final currentYear = currentDate.year;
    final postsForCurrentMonth =
        postsMappedByYearAndMonth[currentYear]![currentMonth]!;
    final List<Post> postsForCurrentDay = postsForCurrentMonth
        .where((element) =>
            element.dateTimeFromString.day == post.dateTimeFromString.day)
        .toList();
    // print('posts for current day');
    // print(postsForCurrentDay);

    if (postsForCurrentDay[0].key == post.key) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    itemPositionsListener.itemPositions.removeListener(checkScrolling);
  }

  @override
  Widget build(BuildContext context) {
    final postsProviderState = ref.watch(postListProvider);
    final appStateProviderState = ref.watch(appStateProvider);
    final appStateProviderNotifier = ref.read(appStateProvider.notifier);
    final postsProviderNotifier = ref.read(postListProvider.notifier);
    final postsMappedByDate = postsProviderState.postsMappedByDate;
    final postsMappedByYearAndMonth =
        postsProviderState.postsMappedByYearAndMonth;

    //

    if (_isLoading)
      return Scaffold(
        backgroundColor: Color.fromRGBO(227, 218, 210, 1),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );

    return Scaffold(
      backgroundColor: postsMappedByDate.entries.isEmpty
          ? Color.fromRGBO(227, 218, 210, 1)
          : Colors.white,
      body: postsMappedByDate.isEmpty
          ? Column(
              children: [
                // Date divider
                _timeDivider(
                  date: DateTime.now(),
                  isToday: true,
                ),
                // Text
                NoPostsInTimelineSection(),
              ],
            )
          : ScrollablePositionedList.builder(
              shrinkWrap: true,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              physics: ClampingScrollPhysics(),
              itemCount: countTotalMonths(postsMappedByYearAndMonth),
              padding: EdgeInsets.only(bottom: 80),
              itemBuilder: (_, i) {
                /*final postsForCurrentMonth =
                    postsMappedByYearAndMonth.entries.toList()[i];

                final postsForNextDate =
                    i < postsMappedByDate.entries.length - 1
                        ? postsMappedByDate.entries.toList()[i + 1]
                        : postsForCurrentDate;

                final currentDateP = postsForCurrentDate.key.dateFromString;
                final nextDateP = postsForNextDate.key.dateFromString;

                bool shouldShowYearDivider = false;
                bool shouldShowMonthDivider = false;
                bool shouldShowMonthDividerForEmptyMonth = false;

                if (postsForCurrentDate.value[0].key ==
                    postsMappedByYearAndMonth[currentDateP.year]![
                            currentDateP.month]![0]
                        .key) {
                  shouldShowMonthDivider = true;
                }

                if (previousYearInTimeLinePost !=
                    currentDateP.year.toString()) {
                  gotFirstPostOfYear = false;
                }
                if (!gotFirstPostOfYear) {
                  Post? firstPostOfYear = postsProviderNotifier
                      .getFirstPostOfYear(currentDateP.year);
                  if (firstPostOfYear != null &&
                      firstPostOfYear.key == postsForCurrentDate.value[0].key) {
                    previousYearInTimeLinePost = currentDateP.year.toString();
                    shouldShowYearDivider = true;
                    gotFirstPostOfYear = true;
                  }
                }*/
                bool shouldShowYearDivider = false;
                bool shouldShowMonthDivider = false;
                bool shouldShowDayDivider = false;

                // these are reversed to show the most recent posts first

                var monthForPost = 12 - (i % 12);

                var yearIndex = (i / 12).floor();
                var yearForPost = postsMappedByYearAndMonth.keys
                    .toList()
                    .reversed
                    .toList()[yearIndex.toInt()];

                final dateForPost = DateTime(yearForPost, monthForPost);

                if (dateForPost.month == 1) {
                  shouldShowYearDivider = true;
                }

                return Column(
                  children: [
                    // Month divider
                    MonthDivider(
                        month: dateForPost.month.monthFromInt,
                        year: dateForPost.year.toString()),

                    /*(i == appStateProviderState.valueToScrollToToday)
                        ?
                        // Date divider
                        _timeDivider(
                            date: DateTime.now(),
                            isToday: true,
                          )
                        : SizedBox(),*/

                    // Posts per date
                    for (var post in postsMappedByYearAndMonth[
                        dateForPost.year]![dateForPost.month]!)
                      Column(
                        children: [
                          /// TODO: spostare nello stato tutta questa roba?
                          (DateTime.now().month == dateForPost.month &&
                                  shouldShowTodayDivider(post))
                              ? _timeDivider(
                                  date: DateTime.now(),
                                  isToday: true,
                                )
                              : const SizedBox(),
                          shouldShowTimeDivider(post)
                              ? _timeDivider(
                                  date: post.dateTimeFromString,
                                  isToday: false,
                                )
                              : const SizedBox(),
                          TimeEventItem(
                            post: post,
                            isSelectedItem:
                                postsProviderNotifier.postIsSelected(post),
                            showSelectionCircle:
                                appStateProviderState.isSelectingPosts,
                            onTap: appStateProviderState.isSelectingPosts
                                ? () {
                                    postsProviderNotifier
                                        .addOrRemoveSelectedPost(post: post);
                                  }
                                : null,
                            onLongPress: () {
                              if (appStateProviderState.isSelectingPosts) {
                                appStateProviderNotifier
                                    .setIsSelectingPosts(false);
                                postsProviderNotifier.addOrRemoveSelectedPost();
                                setState(() {});

                                return;
                              }

                              appStateProviderNotifier
                                  .setIsSelectingPosts(true);
                              postsProviderNotifier.addOrRemoveSelectedPost(
                                  post: post);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    shouldShowYearDivider
                        ? YearDivider(year: dateForPost.year.toString())
                        : const SizedBox(),
                  ],
                );
              },
            ),
      floatingActionButton: _showCenterButton
          ? Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  itemScrollController.scrollTo(
                    index: appStateProviderState.valueToScrollToToday,
                    duration: Duration(milliseconds: 1),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(94, 95, 95, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: .1,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.compress_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
