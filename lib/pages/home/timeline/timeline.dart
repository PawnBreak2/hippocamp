import 'package:flutter/material.dart';
import 'package:ippocapp/helpers/extensions/int_extensions.dart';
import 'package:ippocapp/helpers/extensions/string_extensions.dart';
import 'package:ippocapp/providers/posts_provider.dart';
import 'package:ippocapp/providers/wallets_provider.dart';
import 'package:ippocapp/style/styles/colors.dart';
import 'package:ippocapp/style/widgets/componentns/time_event_item.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TimelinePage extends StatefulWidget {
  final bool isSearching;
  const TimelinePage({required this.isSearching});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool _isLoading = true;
  bool _getNewPosts = false;
  bool _showCenterButton = false;

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

  void checkScrolling() async {
    final postsProvider = context.read<PostsProvider>();

    final nearTheStart =
        itemPositionsListener.itemPositions.value.first.index < 3;

    final nearTheEnd = itemPositionsListener.itemPositions.value.last.index ==
        (postsProvider.postsFiltered.length - 1);

    final listIndexesVisible =
        itemPositionsListener.itemPositions.value.map((e) => e.index);
    final showScrollToToday =
        !listIndexesVisible.contains(postsProvider.valueToScrollToBeToday);

    if (showScrollToToday && !_showCenterButton) {
      _showCenterButton = true;
      setState(() {});
    } else if (!showScrollToToday && _showCenterButton) {
      _showCenterButton = false;
      setState(() {});
    }

    if (widget.isSearching) return;

    if (nearTheStart && !postsProvider.endFutureList) {
      if (_getNewPosts) return;

      _getNewPosts = true;
      await postsProvider.getNewPosts(past: false);
      _getNewPosts = false;
    }

    if (nearTheEnd && !postsProvider.endList) {
      if (_getNewPosts) return;

      _getNewPosts = true;
      await postsProvider.getNewPosts(past: true);
      _getNewPosts = false;
    }
  }

  Future<void> _init() async {
    final postsProvider = context.read<PostsProvider>();
    final walletsProvider = context.read<WalletsProvider>();
    if (postsProvider.posts.isEmpty) {
      await postsProvider.getPosts();
      await postsProvider.getAttachmentTypes();
      await walletsProvider.getWallets();

      _isLoading = false;
      setState(() {});
    } else
      _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _init().whenComplete(() async {
      await Future.delayed(Duration(milliseconds: 100));

      final postsProvider = context.read<PostsProvider>();
      itemScrollController.scrollTo(
        index: postsProvider.valueToScrollToBeToday,
        duration: Duration(milliseconds: 1),
      );

      itemPositionsListener.itemPositions.addListener(checkScrolling);
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemPositionsListener.itemPositions.removeListener(checkScrolling);
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = context.watch<PostsProvider>();
    final posts = postsProvider.postsFiltered;

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
      backgroundColor: posts.entries.isEmpty
          ? Color.fromRGBO(227, 218, 210, 1)
          : Colors.white,
      body: posts.isEmpty
          ? Column(
              children: [
                // Date divider
                _timeDivider(
                  date: DateTime.now(),
                  isToday: true,
                ),
                // Text
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(241, 245, 223, 1),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "In questa pagina puoi inserire i tuoi eventi passati / futuri e annotare tutte le cose che ti succedono e che ritieni rilevanti. Clicca nel pulsante in basso a destra (+) per inserire un nuovo post.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          : ScrollablePositionedList.builder(
              shrinkWrap: true,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              physics: ClampingScrollPhysics(),
              itemCount: posts.entries.length,
              padding: EdgeInsets.only(bottom: 80),
              itemBuilder: (_, i) {
                final p = posts.entries.toList()[i];
                final nextP = i < posts.entries.length - 1
                    ? posts.entries.toList()[i + 1]
                    : p;

                final currentDateP = p.key.dateFromString;
                final nextDateP = nextP.key.dateFromString;

                return Column(
                  children: [
                    if (i == 0)
                      // Month divider
                      Container(
                        color: Colors.grey[200],
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "${currentDateP.month.monthFromInt} ${p.key.dateFromString.year}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    if (i == postsProvider.valueToScrollToBeToday)
                      // Date divider
                      _timeDivider(
                        date: DateTime.now(),
                        isToday: true,
                      ),

                    if (p.key.dateFromString !=
                        "${DateTime.now()}".dateFromString)
                      // Date divider
                      _timeDivider(
                        date: p.key.dateFromString,
                        isToday: false,
                      ),

                    // Posts per date
                    for (var j in posts[p.key]!)
                      TimeEventItem(
                        post: j,
                        isSelectedItem: postsProvider.postIsSelected(j),
                        showSelectionCircle: postsProvider.isSelectingPosts,
                        onTap: postsProvider.isSelectingPosts
                            ? () {
                                if (postsProvider.isSelectingPosts)
                                  postsProvider.addOrRemoveSelectedPost(
                                      post: j);
                              }
                            : null,
                        onLongPress: () {
                          if (postsProvider.isSelectingPosts) {
                            postsProvider.isSelectingPosts = false;
                            postsProvider.addOrRemoveSelectedPost();
                            setState(() {});

                            return;
                          }

                          postsProvider.isSelectingPosts = true;
                          postsProvider.addOrRemoveSelectedPost(post: j);
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
                              "${nextDateP.month.monthFromInt} ${nextP.key.dateFromString.year}",
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
                    index: postsProvider.valueToScrollToBeToday,
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
