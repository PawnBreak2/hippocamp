import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/helpers/extensions/int_extensions.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/components/timeline/time_event_item.dart';
import 'package:hippocapp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PostsPerCategory extends ConsumerStatefulWidget {
  final PostCategory category;
  const PostsPerCategory({required this.category});

  @override
  ConsumerState<PostsPerCategory> createState() => _PostsPerCategoryState();
}

class _PostsPerCategoryState extends ConsumerState<PostsPerCategory> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  Map<String, List<Post>> postsPerCategory = {};
  int _filterSelected = 0;

  late PostCategory categorySelected = widget.category;
  bool _loading = true;

  late final postsProviderNotifier = ref.read(postListProvider.notifier);
  late final appStateProviderState = ref.read(appStateProvider);
  late final appStateProviderNotifier = ref.read(appStateProvider.notifier);

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init({
    bool withFinance = false,
    bool withDocs = false,
  }) async {
    postsPerCategory.clear();

    postsPerCategory = await postsProviderNotifier.getPostsFromCategory(
      categoryKey: categorySelected.key,
      withFinance: withFinance,
      withAttachments: withDocs,
    );
    _loading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 230, 222, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 196, 190, 1),
        elevation: 0,
        leading: Container(),
        toolbarHeight: 10,
        shadowColor: Colors.transparent,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          // Appbar
          Container(
            decoration: BoxDecoration(
              color: CustomColors.pinkWhite,
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 5,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Column(
              children: [
                _AppBarSection(
                  category: categorySelected,
                  onCategoryChange: (newCate) {
                    _loading = true;
                    categorySelected = newCate;
                    setState(() {});

                    _init();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonIconFilter(
                        icon:
                            "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/categorie/category-tab-timeline.svg",
                        onTap: () {
                          _filterSelected = 0;
                          setState(() {});
                          _init();
                        },
                        isSelected: _filterSelected == 0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buttonIconFilter(
                            icon:
                                "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/finanza/finanza-infotype.svg",
                            onTap: () {
                              _filterSelected = 1;
                              setState(() {});
                              _init(withFinance: true);
                            },
                            isSelected: _filterSelected == 1,
                          ),
                          SizedBox(width: 32),
                          _buttonIconFilter(
                            icon:
                                "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/documenti/documenti-infotype.svg",
                            onTap: () {
                              _filterSelected = 2;
                              setState(() {});
                              _init(withDocs: true);
                            },
                            isSelected: _filterSelected == 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Loading
          if (_loading)
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),

          // List
          if (postsPerCategory.isNotEmpty)
            ScrollablePositionedList.builder(
              shrinkWrap: true,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              physics: ClampingScrollPhysics(),
              itemCount: postsPerCategory.entries.length,
              padding: EdgeInsets.only(bottom: 80),
              itemBuilder: (_, i) {
                final p = postsPerCategory.entries.toList()[i];
                final nextP = i < postsPerCategory.entries.length - 1
                    ? postsPerCategory.entries.toList()[i + 1]
                    : p;

                final currentDateP = p.key.dateFromString;
                final nextDateP = nextP.key.dateFromString;

                return Column(
                  children: [
                    if (i == 0)
                      // Month divider
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${currentDateP.month.monthFromInt} ${p.key.dateFromString.year}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Posts: ${postsPerCategory.entries.map((e) => e.value.length).fold(0, (a, b) => a + b)}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (i == appStateProviderState.valueToScrollToToday)
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
                    for (var j in postsPerCategory[p.key]!)
                      TimeEventItem(
                        post: j,
                        isSelectedItem: postsProviderNotifier.isPostSelected(j),
                        showSelectionCircle:
                            appStateProviderState.isSelectingPosts,
                        onTap: appStateProviderState.isSelectingPosts
                            ? () {
                                if (appStateProviderState.isSelectingPosts)
                                  postsProviderNotifier.addOrRemoveSelectedPost(
                                      post: j);
                              }
                            : null,
                        onLongPress: () {
                          if (appStateProviderState.isSelectingPosts) {
                            appStateProviderNotifier.setIsSelectingPosts(false);
                            postsProviderNotifier.addOrRemoveSelectedPost();
                            setState(() {});

                            return;
                          }

                          appStateProviderNotifier.setIsSelectingPosts(true);
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
                                fontWeight: FontWeight.bold,
                              ),
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buttonIconFilter({
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.blue : Colors.transparent,
          border: isSelected
              ? Border.all(
                  color: Colors.grey,
                )
              : null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: SvgPicture.network(
          icon,
          width: 26,
          height: 26,
        ),
      ),
    );
  }

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
}

class _AppBarSection extends StatelessWidget {
  final PostCategory category;
  final void Function(PostCategory newCategory) onCategoryChange;
  const _AppBarSection({
    required this.category,
    required this.onCategoryChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.pinkWhite,
      height: 100,
      child: Stack(
        children: [
          // Setting app bar fixed
          // Container with options
          Container(
            color: CustomColors.pinkWhiteDeep,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  onSelected: (c) async {},
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: "0",
                      child: Text("Salva come predefinito"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // All data
          Padding(
            padding: EdgeInsets.only(left: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arrow back
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 26,
                  ),
                ),

                // Image + other
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Image circle
                      InkWell(
                        onTap: () => onCategoryAvatarClick(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(239, 230, 222, 1),
                            border: Border.all(
                              color: Color.fromRGBO(239, 230, 222, 1),
                              width: 12,
                            ),
                            shape: BoxShape.circle,
                          ),
                          width: 100,
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: category
                                  .domainBackgroundColorHex.colorFromHex,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: SvgPicture.network(
                              category.iconUrl,
                            ),
                          ),
                        ),
                      ),

                      // Partner + title
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onCategoryAvatarClick(BuildContext context) async {
    final resp = await CustomBottomSheet.showFullDialog(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 5,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Container(
              height: 150,
              color: Colors.white,
              child: Consumer(
                builder: (context, ref, child) {
                  final appStateProviderState = ref.watch(appStateProvider);
                  final categories = appStateProviderState.categoriesInDomains;

                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemBuilder: (_, i) => Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        onTap: () => Navigator.pop(context, categories[i]),
                        child: SizedBox(
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: categories[i]
                                      .domainBackgroundColorHex
                                      .colorFromHex,
                                  border: Border.all(
                                    width: categories[i].key == category.key
                                        ? 4
                                        : 1,
                                    color: categories[i].key == category.key
                                        ? CustomColors.primaryRed
                                        : Colors.grey,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.network(
                                  categories[i].iconUrl,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                categories[i].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: categories.length,
                    separatorBuilder: (_, i) => SizedBox(width: 8),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    if (resp == null) return;

    onCategoryChange(resp);
  }
}
