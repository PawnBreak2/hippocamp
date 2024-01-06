import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/helpers/extensions/datetime_extension.dart';
import 'package:hippocapp/helpers/extensions/int_extensions.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/helpers/ui/timeline/timeline_helpers.dart';
import 'package:hippocapp/models/repositories/app_state_repository.dart';
import 'package:hippocapp/models/repositories/post_repository.dart';
import 'package:hippocapp/models/repositories/ui_state_repository.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';
import 'package:hippocapp/providers/posts_management/support/wallets_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/components/timeline/time_event_item.dart';
import 'package:hippocapp/widgets/components/timeline/month_divider.dart';
import 'package:hippocapp/widgets/components/timeline/no_posts_in_timeline.dart';
import 'package:hippocapp/widgets/components/timeline/time_divider.dart';
import 'package:hippocapp/widgets/components/timeline/year_divider.dart';
import 'package:hippocapp/widgets/views/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:hippocapp/constants/common.dart';

class TimelinePage extends ConsumerStatefulWidget {
  final bool isSearching;
  const TimelinePage({required this.isSearching});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage>
    with AutomaticKeepAliveClientMixin {
  // used to avoid the repetition of the call to the getFirstPostOfTheYear function saving resources
  bool gotFirstPostOfYear = false;
  String processedYear = '';
  // used to check the previous year of post rendered and activate dividers accordingly
  String previousYearInTimeLinePost = '';
  int indexForMonths = 0;
  bool _isLoading = true;
  bool _getNewPosts = false;
  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;
  late int valueToScrollToToday;
  late UIState uiStateProviderState;
  late UIStateNotifier uiStateProviderNotifier;
  late AppState appStateProviderState;
  late AppStateNotifier appStateProviderNotifier;
  late PostsRepository postsProviderState;
  late PostListNotifier postsProviderNotifier;
  bool _showCenterButton = false;
  Map<int, Map<int, List<Post>>> mappedPosts = {};

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    ref.listenManual(postListProvider, (previous, next) {
      mappedPosts = next.postsMappedByYearAndMonth;
    }, fireImmediately: true);

    super.initState();
    _init().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 5000));

      itemPositionsListener.itemPositions.addListener(checkScrolling);
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemPositionsListener.itemPositions.removeListener(checkScrolling);
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _init() async {
    uiStateProviderState = ref.read(uiStateProvider);
    uiStateProviderNotifier = ref.read(uiStateProvider.notifier);
    appStateProviderState = ref.read(appStateProvider);
    appStateProviderNotifier = ref.read(appStateProvider.notifier);
    postsProviderState = ref.read(postListProvider);
    postsProviderNotifier = ref.read(postListProvider.notifier);
    valueToScrollToToday = ref.read(appStateProvider).valueToScrollToToday;

    final walletsProviderNotifier = ref.read(walletsProvider.notifier);
    if (postsProviderState.allPosts.isEmpty) {
      await postsProviderNotifier.getPosts();
      await appStateProviderNotifier.getAttachmentTypes();
      await walletsProviderNotifier.getWallets();

      _isLoading = false;
      setState(() {});
    } else {
      _isLoading = false;
    }
    await Future.delayed(const Duration(milliseconds: 500), () {
      itemScrollController.scrollTo(
        index: valueToScrollToToday,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  Future<bool> requestNewPosts(DateTime dateTime) async {
    await postsProviderNotifier.getNewPosts(
        past: true, dateTime: dateTime, monthsToGoBack: 2);

    return true;
  }

  void checkScrolling() async {
    DateTime start = DateTime.now();
    List orderedIndexes = itemPositionsListener.itemPositions.value
        .map((e) => e.index)
        .sorted((a, b) => b.compareTo(a));
    int itemCountInTimeline = TimelineHelpers.countTotalMonths(ref.read(
        postListProvider.select((state) => state.postsMappedByYearAndMonth)));
    orderedIndexes.sort((a, b) => b.compareTo(a));
    DateTime? lastDateTimeForRequestingPosts =
        appStateProviderState.lastDateTimeForRequestingPosts;
    // gets the highest number in orderedIndexes ie the earliest month in the list
    int firstMonthIndex = orderedIndexes.first;

    var firstMonth = 12 - (firstMonthIndex % 12);
    var firstYearIndex = (firstMonthIndex / 12).floor();
    var firstYear =
        mappedPosts.keys.toList().reversed.toList()[firstYearIndex.toInt()];
    DateTime dateTimeForFirstYearMonth = DateTime(firstYear, firstMonth);
    final dateTimeToTriggerRequestingPosts = DateTime(
        lastDateTimeForRequestingPosts!.year,
        lastDateTimeForRequestingPosts!.month - 2);

    if (dateTimeForFirstYearMonth == dateTimeToTriggerRequestingPosts) {
      print('DO IT');
    }

    ///TODO: da implementare refresh

    final nearTheStart =
        itemPositionsListener.itemPositions.value.first.index < 3;

    final nearTheEnd = itemPositionsListener.itemPositions.value.last.index ==
        (postsProviderState.allPosts.length - 2);

    final listIndexesVisible =
        itemPositionsListener.itemPositions.value.map((e) => e.index);

    final showScrollToToday =
        (!listIndexesVisible.contains(valueToScrollToToday) ||
            itemPositionsListener.itemPositions.value
                    .where((element) => element.index == valueToScrollToToday)
                    .first
                    .itemLeadingEdge <
                -0.35);

    if (showScrollToToday && !_showCenterButton) {
      uiStateProviderNotifier.setShowCenterButtonInTimeline(true);
      _showCenterButton = true;
    } else if (!showScrollToToday && _showCenterButton) {
      uiStateProviderNotifier.setShowCenterButtonInTimeline(false);

      _showCenterButton = false;
    }

    if (widget.isSearching) return;

    if (nearTheEnd && !postsProviderState.endList) {
      if (_getNewPosts) return;

      _getNewPosts = true;
      //await postsProviderNotifier.getNewPosts(past: true);
      _getNewPosts = false;
    }
    DateTime end = DateTime.now();
    Duration duration = end.difference(start);

    // print('checkScrolling executed in ${duration.inMilliseconds} milliseconds');
  }

  bool shouldShowTodayDivider(Post processedPost) {
    final postsProviderState = ref.watch(postListProvider);
    final postsMappedByYearAndMonth =
        postsProviderState.postsMappedByYearAndMonth;

    final currentDate = DateTime.now();
    final currentMonth = currentDate.month;
    final currentYear = currentDate.year;
    final postsForCurrentMonth =
        postsMappedByYearAndMonth[currentYear]![currentMonth]!;

    // if there are no posts for current month, show the today divider

    if (postsForCurrentMonth.isEmpty) {
      return true;
    }

    // if there are posts for current month, check if the processed post is the first one of the month
    // in that case, put the today divider on top of it

    final Post? postBeforeToday = postsForCurrentMonth.firstWhereOrNull(
        (element) => element.date.dateFromString.isBefore(currentDate));

    if (processedPost.key == postBeforeToday?.key) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowTimeDivider(Post post) {
    final postsProviderState = ref.watch(postListProvider);
    final postsMappedByYearAndMonth =
        postsProviderState.postsMappedByYearAndMonth;

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

  @override
  Widget build(BuildContext context) {
    final postsMappedByYearAndMonth = ref.watch(
        postListProvider.select((state) => state.postsMappedByYearAndMonth));
    final isSearchingPosts =
        ref.watch(appStateProvider.select((state) => state.isSearchingPosts));
    final bool isPostListEmpty = postsMappedByYearAndMonth.entries.isEmpty;

    //
    print('value to scroll to today');
    inspect(postsMappedByYearAndMonth);
    print(appStateProviderState.valueToScrollToToday);
    if (_isLoading) {
      return const LoadingScreen();
    }

    return Scaffold(
        backgroundColor: isPostListEmpty
            ? const Color.fromRGBO(227, 218, 210, 1)
            : Colors.white,
        body: isPostListEmpty
            ? Column(
                children: [
                  // Date divider
                  TimelineTimeDivider(date: DateTime.now(), isToday: true),
                  // Text
                  const NoPostsInTimelineSection(),
                ],
              )
            : isSearchingPosts
                ? ListView.builder(
                    itemCount: ref.watch(postListProvider
                        .select((state) => state.searchedPosts.length)),
                    itemBuilder: (_, i) {
                      List searchedPosts = ref.watch(postListProvider
                          .select((state) => state.searchedPosts));
                      if (searchedPosts.isEmpty) {
                        print('is empty');
                        return const SizedBox();
                      }
                      return TimeEventItem(
                        post: searchedPosts[i],
                        isSelectedItem: false,
                        showSelectionCircle: false,
                        onTap: null,
                        onLongPress: null,
                      );
                    },
                  )
                : ScrollablePositionedList.builder(
                    shrinkWrap: true,
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    physics: const ClampingScrollPhysics(),
                    itemCount: TimelineHelpers.countTotalMonths(
                        postsMappedByYearAndMonth),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (_, i) {
                      bool shouldShowYearDivider = false;

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
                        key: ValueKey(dateForPost),
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
                          // Posts per date (sorted by time)
                          for (var post in postsMappedByYearAndMonth[
                              dateForPost.year]![dateForPost.month]!
                            ..sort((a, b) => b.dateTimeFromString
                                .compareTo(a.dateTimeFromString)))
                            Builder(builder: (context) {
                              String today =
                                  DateFormat.yMd().format(DateTime.now());
                              String dayOfPost = DateFormat.yMd()
                                  .format(post.dateTimeFromString);
                              return Column(
                                children: [
                                  /// TODO: spostare nello stato tutta questa roba?
                                  (DateTime.now().month == dateForPost.month &&
                                          shouldShowTodayDivider(post))
                                      ? TimelineTimeDivider(
                                          date: DateTime.now(), isToday: true)
                                      : const SizedBox(),
                                  (shouldShowTimeDivider(post) &&
                                          today != dayOfPost)
                                      ? TimelineTimeDivider(
                                          date: post.dateTimeFromString,
                                          isToday: false)
                                      : const SizedBox(),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final bool isSelectingPosts = ref.watch(
                                          appStateProvider.select((state) =>
                                              state.isSelectingPosts));
                                      bool isThereOnlyThisPostSelected =
                                          (ref.watch(postListProvider.select(
                                              (state) =>
                                                  state.selectedPosts.length ==
                                                      1 &&
                                                  state.selectedPosts
                                                      .contains(post))));

                                      return TimeEventItem(
                                        post: post,
                                        isSelectedItem: postsProviderNotifier
                                            .isPostSelected(post),
                                        showSelectionCircle: isSelectingPosts,
                                        onTap: isSelectingPosts
                                            ? () {
                                                postsProviderNotifier
                                                    .addOrRemoveSelectedPost(
                                                        post: post);
                                                if (isThereOnlyThisPostSelected) {
                                                  appStateProviderNotifier
                                                      .setIsSelectingPosts(
                                                          false);
                                                }
                                              }
                                            : null,
                                        onLongPress: () {
                                          if (isSelectingPosts) {
                                            appStateProviderNotifier
                                                .setIsSelectingPosts(false);
                                            postsProviderNotifier
                                                .addOrRemoveSelectedPost();
                                            setState(() {});

                                            return;
                                          }

                                          appStateProviderNotifier
                                              .setIsSelectingPosts(true);
                                          postsProviderNotifier
                                              .addOrRemoveSelectedPost(
                                                  post: post);

                                          ///TODO: lasciarlo?
                                          setState(() {});
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            }),
                          shouldShowYearDivider
                              ? YearDivider(year: dateForPost.year.toString())
                              : const SizedBox(),
                        ],
                      );
                    },
                  ),
        floatingActionButton: Consumer(
          builder: (context, ref, child) {
            bool showCenterButton = ref.watch(uiStateProvider
                .select((state) => state.showCenterButtonInTimeline));

            return showCenterButton
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
                : SizedBox();
          },
        ));
  }
}
