import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/pages/attachments/attachments_page.dart';
import 'package:hippocamp/pages/calendar/calendar_page.dart';
import 'package:hippocamp/pages/categories/categories_page.dart';
import 'package:hippocamp/pages/finance/finance_page.dart';
import 'package:hippocamp/pages/home/home_page.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MainScaffold> {
  int _index = 0;
  final List<Map> _pages = [
    {
      "name": "Home",
      "page": HomePage(),
      "icon": "assets/icons/nav-bar-home.png",
    },
    {
      "name": "Categorie",
      "page": CategoriesPage(),
      "icon": "assets/icons/nav-bar-category.png",
    },
    {
      "name": "Moduli",
      "page": FinancePage(),
      "icon": "assets/icons/nav-bar-category.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appStateProviderState = ref.watch(appStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _pages[_index]["page"]),
          if (_index == 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: _calendarButton(),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: UnconstrainedBox(
        child: Container(
          width: 100.w,
          height: 9.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                color: Colors.black12,
              ),
            ],
          ),
          child: appStateProviderState.isSelectingPosts
              ? _selectionPostsBottomBar()
              : _defaultBottomBar(),
        ),
      ),
    );
  }

  Widget _calendarButton() {
    return InkWell(
      onTap: () {
        CustomBottomSheet.showDraggableBottomSheet(
          context,
          (controller) => CalendarPage(
            scrollController: controller,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(94, 95, 95, 1),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: .1,
              color: Colors.black38,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Icon(
          Icons.calendar_month,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _defaultBottomBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < _pages.length; i++)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 3,
                    color: i == _index
                        ? CustomColors.primaryRed
                        : Colors.transparent,
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  _index = i;
                  setState(() {});
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.black.withOpacity(.1),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      _pages[i]["icon"],
                      color:
                          i == _index ? CustomColors.primaryRed : Colors.grey,
                      height: 20,
                    ),
                    Text(
                      _pages[i]["name"],
                      style: TextStyle(
                        color:
                            i == _index ? CustomColors.primaryRed : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _selectionPostsBottomBar() {
    return Container(
      color: Color.fromRGBO(239, 245, 251, 1),
      padding: EdgeInsets.only(
        left: 16,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: Consumer(
                  builder: (context, ref, child) {
                    final appStateProviderNotifier =
                        ref.read(appStateProvider.notifier);
                    final postsProviderNotifier =
                        ref.read(postListProvider.notifier);

                    return InkWell(
                      onTap: () {
                        appStateProviderNotifier.setIsSelectingPosts(false);
                        postsProviderNotifier.addOrRemoveSelectedPost();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: CustomColors.primaryBlue,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 8),
              Consumer(
                builder: (context, ref, child) {
                  final selectedPostsLength = ref.watch(postListProvider
                      .select((state) => state.selectedPosts.length));

                  return Text(
                    "${selectedPostsLength}",
                    style: TextStyle(
                      color: CustomColors.primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),

          // Buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Consumer(
                  builder: (context, ref, child) {
                    final postsProviderNotifier =
                        ref.read(postListProvider.notifier);
                    final postsProviderState = ref.read(postListProvider);

                    return InkWell(
                      onTap: () async {
                        await postsProviderNotifier.duplicatePosts(
                          postKeys: postsProviderState.selectedPosts
                              .map((e) => e.key)
                              .toList(),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.copy,
                              color: CustomColors.primaryBlue,
                              size: 20,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Duplica\npost",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CustomColors.primaryBlue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: Consumer(
                  builder: (context, ref, child) {
                    final postsProviderNotifier =
                        ref.read(postListProvider.notifier);
                    final postsProviderState = ref.read(postListProvider);

                    return InkWell(
                      onTap: () async {
                        await postsProviderNotifier.deletePosts(
                          postsKey: postsProviderState.selectedPosts
                              .map((e) => e.key)
                              .toList(),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: CustomColors.primaryBlue,
                              size: 20,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Elimina\npost",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CustomColors.primaryBlue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
