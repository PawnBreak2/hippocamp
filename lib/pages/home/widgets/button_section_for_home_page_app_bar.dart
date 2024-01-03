import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/providers/ui_state_provider.dart';
import 'package:hippocapp/styles/colors.dart';

class ButtonForHomePageAppBar extends ConsumerWidget {
  final String _text;
  final String _icon;
  // index of the button, used to determine which page to go to
  final int _index;
  final PageController _pageController;
  ButtonForHomePageAppBar({
    Key? key,
    required PageController pageController,
    required int index,
    required String text,
    required String icon,
  })  : _text = text,
        _icon = icon,
        _index = index,
        _pageController = pageController,
        super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        int indexForHomePageAppBar = ref.watch(
            uiStateProvider.select((state) => state.indexForHomePageAppBar));
        return InkWell(
          onTap: () {
            ref
                .read(uiStateProvider.notifier)
                .setIndexForHomePageAppBar(_index);
            _pageController.jumpToPage(_index);
          },
          child: Container(
            width: 90,
            decoration: BoxDecoration(
              border: indexForHomePageAppBar == _index
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
                opacity: indexForHomePageAppBar == _index ? 1 : .25,
                child: child),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.network(
            _icon,
            width: 26,
            height: 26,
            color: Colors.black,
          ),
          Text(_text),
        ],
      ),
    );
  }
}
