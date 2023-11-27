import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:hippocamp/pages/attachments/attachments_page.dart';
import 'package:hippocamp/pages/calendar/calendar_page.dart';
import 'package:hippocamp/pages/categories/categories_page.dart';
import 'package:hippocamp/pages/finance/finance_page.dart';
import 'package:hippocamp/pages/home/home_page.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/components/main_scaffold/default_bottom_bar.dart';
import 'package:hippocamp/widgets/components/main_scaffold/post_selection_bottom_bar.dart';
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
      "page": const HomePage(),
      "icon": "assets/icons/nav-bar-home.png",
    },
    {
      "name": "Categorie",
      "page": const CategoriesPage(),
      "icon": "assets/icons/nav-bar-category.png",
    },
    {
      "name": "Moduli",
      "page": const FinancePage(),
      "icon": "${Constants.iconAssetsPath}nav-bar-category.png",
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
          height: 10.h,
          decoration: const BoxDecoration(
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
              ? PostSelectionBottomBar()
              : DefaultBottomBar(
                  index: _index,
                  pages: _pages,
                  onPressed: (i) {
                    _index = i;
                    setState(() {});
                  },
                ),
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
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(94, 95, 95, 1),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            const BoxShadow(
              blurRadius: 10,
              spreadRadius: .1,
              color: Colors.black38,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: const Icon(
          Icons.calendar_month,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
