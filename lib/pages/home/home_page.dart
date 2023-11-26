import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/pages/change_password/change_password.dart';
import 'package:hippocamp/pages/login/login_page.dart';
import 'package:hippocamp/pages/memo/create_memo_page.dart';
import 'package:hippocamp/pages/memo/memo.dart';
import 'package:hippocamp/pages/post_creation/post_creation_dialog.dart';
import 'package:hippocamp/pages/timeline/timeline.dart';
import 'package:hippocamp/providers/auth_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:hippocamp/widgets/forms/primary_text_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// this page contains timeline and memo pages

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _FinancePageState();
}

class _FinancePageState extends ConsumerState<HomePage> {
  late final postProvider = ref.read(postListProvider.notifier);

  int _index = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  bool _searchFieldActive = false;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _timerForSearching;

  Widget _sectionButton({
    required int i,
    required String text,
    required String icon,
  }) {
    return InkWell(
      onTap: () {
        _index = i;
        _pageController.jumpToPage(i);
        setState(() {});
      },
      child: Container(
        width: 90,
        decoration: BoxDecoration(
          border: _index == i
              ? Border(
                  bottom: BorderSide(
                    color: CustomColors.grey121,
                    width: 3,
                  ),
                )
              : null,
        ),
        padding: EdgeInsets.only(bottom: 6),
        child: Opacity(
          opacity: _index == i ? 1 : .25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.network(
                icon,
                width: 26,
                height: 26,
                color: Colors.black,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page!.round() != _index) {
        _index = _pageController.page!.round();
        setState(() {});
      }
    });
  }

  Future<void> searchTextInPosts() async {
    if (_timerForSearching != null) {
      _timerForSearching!.cancel();
      _timerForSearching = null;
    }

    _timerForSearching = Timer.periodic(
      Duration(milliseconds: 500),
      (timer) async {
        if (_textEditingController.text.isEmpty)
          await postProvider.getPosts();
        else {
          await postProvider.searchPosts(_textEditingController.text);
          _timerForSearching = null;
          timer.cancel();
        }
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(100.w, 60),
        child: SafeArea(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(color: Colors.black26, width: 2),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!_searchFieldActive)
                    Row(
                      children: [
                        // TIMELINE Section button
                        _sectionButton(
                          i: 0,
                          text: "Timeline",
                          icon:
                              "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/top-nav-bar/top-nav-bar-timeline-active.svg",
                        ),
                        SizedBox(width: 14),
                        // MEMO Section button
                        _sectionButton(
                          i: 1,
                          text: "Memo",
                          icon:
                              "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/top-nav-bar/top-nav-bar-memo-inactive.svg",
                        ),
                      ],
                    ),

                  // Icon back & search field
                  if (_searchFieldActive)
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              postProvider.getPosts();
                              _searchFieldActive = false;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: PrimaryTextFormField(
                              controller: _textEditingController,
                              hintText: "Cerca",
                              focusNode: _focusNode,
                              backgroundColor: Colors.white,
                              action: TextInputAction.search,
                              onChange: (_) {
                                searchTextInPosts();
                              },
                              suffixIcon: InkWell(
                                onTap: () {
                                  if (_textEditingController.text.isNotEmpty) {
                                    _textEditingController.clear();
                                    postProvider.getPosts();
                                    setState(() {});
                                  }
                                },
                                child: _textEditingController.text.isNotEmpty
                                    ? Icon(Icons.clear)
                                    : Icon(Icons.search),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Last actions
                  if (!_searchFieldActive)
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _searchFieldActive = true;
                            _focusNode.requestFocus();
                            setState(() {});
                          },
                          icon: SvgPicture.network(
                            "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/top-nav-bar/lente-search.svg",
                            height: 28,
                            width: 28,
                          ),
                          splashRadius: 26,
                          iconSize: 26,
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                          onSelected: (c) {
                            switch (c) {
                              case "0":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChangePasswordPage(),
                                  ),
                                );
                                break;
                              case "1":
                                ref
                                    .read(authProvider.notifier)
                                    .logout()
                                    .whenComplete(() => context
                                        .goNamed(routeMap[routeNames.login]));
                                break;
                            }
                          },
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              value: "0",
                              child: Text("Cambia password"),
                            ),
                            PopupMenuItem(
                              value: "1",
                              child: Text("Logout"),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          TimelinePage(isSearching: _searchFieldActive),
          MemoPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        heroTag: "FloatingActionButton_timeline",
        onPressed: () {
          if (_index == 0)
            CustomBottomSheet.showDraggableBottomSheet(
              context,
              (controller) => PostCreationDialog(
                scrollController: controller,
              ),
            );
          else
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateMemoPage(),
              ),
            );
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: CustomColors.lightRed,
          size: 32,
        ),
      ),
    );
  }
}
