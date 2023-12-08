import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/models/repositories/app_state_repository.dart';
import 'package:hippocamp/models/repositories/ui_state_repository.dart';
import 'package:hippocamp/pages/change_password/change_password.dart';
import 'package:hippocamp/pages/home/widgets/app_bar_for_homepage.dart';
import 'package:hippocamp/pages/login/login_page.dart';
import 'package:hippocamp/pages/memo/create_memo_page.dart';
import 'package:hippocamp/pages/memo/memo.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/page_controller_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/widgets/components/post_creation_and_update/select_category_dialog.dart';
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
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final AppState _appState;
  late final UIStateNotifier _uiStateNotifier;
  late final UIState _uiState;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  final FocusNode _focusNode = FocusNode();

  /// Widget that represents the button for accessing the Timeline / Memo sections on home page.

  @override
  void initState() {
    _appState = ref.read(appStateProvider);
    _pageController = ref.read(homepagePageControllerProvider);
    _uiStateNotifier = ref.read(uiStateProvider.notifier);
    _uiState = ref.read(uiStateProvider);
    _pageController.addListener(() {
      if (_pageController.page!.round() != _uiState.indexForHomePageAppBar) {
        _uiStateNotifier
            .setIndexForHomePageAppBar(_pageController.page!.round());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _index = ref
        .watch(uiStateProvider.select((value) => value.indexForHomePageAppBar));
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(100.w, 60),
        child: AppBarForHomePage(
          pageController: _pageController,
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          TimelinePage(isSearching: _appState.isSearchingPosts),
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
              (controller) => SelectCategoriesDialog(
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
