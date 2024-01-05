import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/pages/home/widgets/button_section_for_home_page_app_bar.dart';
import 'package:hippocapp/providers/services/page_controller_provider.dart';

class HomePageAppBarNavigationButtons extends ConsumerWidget {
  const HomePageAppBarNavigationButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // TIMELINE Section button
        ButtonForHomePageAppBar(
          pageController: ref.read(homepagePageControllerProvider),
          index: 0,
          text: "Timeline",
          icon:
              "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/top-nav-bar/top-nav-bar-timeline-active.svg",
        ),
        SizedBox(width: 14),
        // MEMO Section button
        ButtonForHomePageAppBar(
          pageController: ref.read(homepagePageControllerProvider),
          index: 1,
          text: "Memo",
          icon:
              "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/top-nav-bar/top-nav-bar-memo-inactive.svg",
        ),
      ],
    );
  }
}
