import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocapp/constants/common.dart';
import 'package:hippocapp/constants/navigation/routeNames.dart';
import 'package:hippocapp/models/repositories/app_state_repository.dart';
import 'package:hippocapp/models/repositories/ui_state_repository.dart';
import 'package:hippocapp/pages/change_password/change_password.dart';
import 'package:hippocapp/pages/home/widgets/app_bar_for_homepage.dart';
import 'package:hippocapp/pages/login/login_page.dart';
import 'package:hippocapp/pages/memo/create_memo_page.dart';
import 'package:hippocapp/pages/memo/memo.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/services/page_controller_provider.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';
import 'package:hippocapp/pages/select_categories/select_category_dialog.dart';
import 'package:hippocapp/pages/timeline/timeline.dart';
import 'package:hippocapp/providers/auth/auth_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:hippocapp/widgets/forms/primary_text_form.dart';
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

  /// Widget that represents the button for accessing the Timeline / Memo sections on home page.

  @override
  void initState() {
    _appState = ref.read(appStateProvider);
    _pageController = ref.read(homepagePageControllerProvider);
    _uiStateNotifier = ref.read(uiStateProvider.notifier);
    _uiState = ref.read(uiStateProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        onPageChanged: (index) {
          _uiStateNotifier.setIndexForHomePageAppBar(index);
        },
        children: [
          TimelinePage(isSearching: _appState.isSearchingPosts),
          MemoPage(),
        ],
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          int _index = ref.watch(
              uiStateProvider.select((value) => value.indexForHomePageAppBar));

          return FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              heroTag: "FloatingActionButton_timeline",
              onPressed: () {
                if (_index == 0) {
                  CustomBottomSheet.showDraggableBottomSheet(
                    context,
                    (controller) => SelectCategoriesDialog(
                      scrollController: controller,
                    ),
                  ).whenComplete(

                      // reset the domains to always show the first one after the user closes and reopens the bottom sheet
                      () => Future.delayed(Duration(milliseconds: 500), () {
                            ref
                                .read(uiStateProvider.notifier)
                                .setSelectedDomainKey(
                                    ref.read(appStateProvider).domains[0].key);
                          }));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateMemoPage(),
                    ),
                  );
                }
              },
              backgroundColor: Colors.white,
              child: child);
        },
        child: const Icon(
          Icons.add,
          color: CustomColors.lightRed,
          size: 32,
        ),
      ),
    );
  }
}
