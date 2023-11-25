import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';

class DefaultBottomBar extends StatelessWidget {
  late List _pages;
  late int _index;
  late Function _onPressed;
  DefaultBottomBar(
      {super.key, required pages, required onPressed, required index}) {
    _pages = pages;
    _index = index;
    _onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
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
                  _onPressed(i);
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
}
