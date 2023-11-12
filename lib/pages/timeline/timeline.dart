import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TimelinePage extends ConsumerStatefulWidget {
  final bool isSearching;
  const TimelinePage({required this.isSearching});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
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
      final postsProviderNotifier = ref.read(postListProvider.notifier);
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
      await postsProviderNotifier.getNewPosts(past: false);
      _getNewPosts = false;
    }

    if (nearTheEnd && !postsProviderNotifier.endList) {
      if (_getNewPosts) return;

      _getNewPosts = true;
      await postsProviderNotifier.getNewPosts(past: true);
      _getNewPosts = false;
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
    final postsProviderNotifier = ref.read(postListProvider.notifier);
    final postsMappedByDate = postsProviderState.postsMappedByDate;
    final postsMappedByYearAndMonth =
        postsProviderState.postsMappedByYearAndMonth;
    print('value to scroll to');
    print(ref.read(appStateProvider).valueToScrollToToday);
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
              itemCount: postsMappedByDate.entries.length,
              padding: EdgeInsets.only(bottom: 80),
              itemBuilder: (_, i) {
                /*    The variable p is assigned to the current entry in the posts.entries list for the given index i. Each entry in this list is a key-value pair, where the key is a string representing a date and the value is a list of posts (List<Post>) for that date.
                 The p variable is used within the itemBuilder to:
                 Display dividers (month, year, date) based on the date of the current entry.
                 Render the posts for the current date.
                 Determine if the layout needs to include a divider for a change in year or month when compared to the next post entry (using nextP).*/

                final postsForCurrentDate =
                    postsMappedByDate.entries.toList()[i];

                /*   nextP is assigned to the next entry in posts.entries if the current index i is not the last one. If i is the last index, nextP is set to the same value as p.
                This is used to check if there is a change in the year or month between the current post entry (p) and the next post entry (nextP). If there is a change, this indicates the need  to insert a year or month divider in the layout.
                The conditional assignment of nextP ensures that even for the last post entry, there's a valid nextP to compare against, avoiding an index out of range error.
                */

                final postsForNextDate =
                    i < postsMappedByDate.entries.length - 1
                        ? postsMappedByDate.entries.toList()[i + 1]
                        : postsForCurrentDate;

                final currentDateP = postsForCurrentDate.key.dateFromString;
                final nextDateP = postsForNextDate.key.dateFromString;
                print('current key');
                print(postsForCurrentDate.value[0].key);
                print('repo key');

                print(postsMappedByYearAndMonth[currentDateP.year]![
                        currentDateP.month]![0]
                    .key);
                return Column(
                  children: [
                    if (postsForCurrentDate.value[0].key ==
                        postsMappedByYearAndMonth[currentDateP.year]![
                                currentDateP.month]![0]
                            .key)
                      // Month divider
                      MonthDivider(
                          currentDateP: currentDateP,
                          postsForCurrentDate: postsForCurrentDate),
                    if (i == appStateProviderState.valueToScrollToToday)
                      // Date divider
                      _timeDivider(
                        date: DateTime.now(),
                        isToday: true,
                      ),

                    if (postsForCurrentDate.key.dateFromString !=
                        "${DateTime.now()}".dateFromString)
                      // Date divider
                      _timeDivider(
                        date: postsForCurrentDate.key.dateFromString,
                        isToday: false,
                      ),

                    // Posts per date
                    for (var j in postsMappedByDate[postsForCurrentDate.key]!)
                      TimeEventItem(
                        post: j,
                        isSelectedItem: postsProviderNotifier.postIsSelected(j),
                        showSelectionCircle:
                            postsProviderNotifier.isSelectingPosts,
                        onTap: postsProviderNotifier.isSelectingPosts
                            ? () {
                                if (postsProviderNotifier.isSelectingPosts)
                                  postsProviderNotifier.addOrRemoveSelectedPost(
                                      post: j);
                              }
                            : null,
                        onLongPress: () {
                          if (postsProviderNotifier.isSelectingPosts) {
                            postsProviderNotifier.isSelectingPosts = false;
                            postsProviderNotifier.addOrRemoveSelectedPost();
                            setState(() {});

                            return;
                          }

                          postsProviderNotifier.isSelectingPosts = true;
                          postsProviderNotifier.addOrRemoveSelectedPost(
                              post: j);
                          setState(() {});
                        },
                      ),

                    // Year divider
                    if (currentDateP.year != nextDateP.year)
                      Container(
                        color: Colors.blueGrey[100],
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${nextDateP.year}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                    // Month divider
                    if (currentDateP.month != nextDateP.month)
                      Container(
                        color: Colors.grey[200],
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "${nextDateP.month.monthFromInt} ${postsForNextDate.key.dateFromString.year}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
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
