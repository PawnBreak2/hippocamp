import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/models/repositories/app_state_repository.dart';
import 'package:hippocamp/models/repositories/ui_state_repository.dart';
import 'package:hippocamp/pages/change_password/change_password.dart';
import 'package:hippocamp/pages/home/widgets/button_section_for_home_page_app_bar.dart';
import 'package:hippocamp/pages/home/widgets/home_page_app_bar_action_buttons.dart';
import 'package:hippocamp/pages/home/widgets/home_page_app_bar_navigation_buttons.dart';
import 'package:hippocamp/pages/home/widgets/home_page_search_bar.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/auth_provider.dart';
import 'package:hippocamp/providers/page_controller_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/widgets/forms/primary_text_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppBarForHomePage extends ConsumerStatefulWidget {
  const AppBarForHomePage({
    super.key,
    required PageController pageController,
  });

  @override
  ConsumerState<AppBarForHomePage> createState() => _AppBarForHomePageState();
}

class _AppBarForHomePageState extends ConsumerState<AppBarForHomePage> {
  late UIState _uiState;
  late AppState _appState;
  late AppStateNotifier _appStateNotifier;
  late UIStateNotifier _uiNotifier;
  late PostListNotifier _postListNotifier;
  late AuthNotifier _authNotifier;
  late FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _uiState = ref.read(uiStateProvider);
    _appState = ref.read(appStateProvider);
    _appStateNotifier = ref.read(appStateProvider.notifier);
    _uiNotifier = ref.read(uiStateProvider.notifier);
    _postListNotifier = ref.read(postListProvider.notifier);
    _authNotifier = ref.read(authProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Colors.black26, width: 2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Consumer(
            builder: (context, ref, child) {
              bool isSearchFieldActive = ref.watch(uiStateProvider
                  .select((state) => state.showSearchFieldForPosts));

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isSearchFieldActive) HomePageAppBarNavigationButtons(),
                  HomePageAppBarActionButtons(),
                  // Icon back & search field
                  if (isSearchFieldActive) HomePageSearchBar(),

                  // Last actions
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
