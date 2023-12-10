import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';

/// shows the icons on the top bar of post detail page, like important, uncertain, sensitive etc.
class AppBarPostDetailIcon extends StatelessWidget {
  final IconData _icon;
  final Color _color;
  AppBarPostDetailIcon({
    Color? backgroundColor,
    required IconData icon,
    super.key,
  })  : _icon = icon,
        _color =
            backgroundColor == null ? CustomColors.primaryRed : backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: _color,
        shape: BoxShape.rectangle,
        boxShadow: const [
          BoxShadow(
            spreadRadius: 3,
            blurRadius: 5,
            color: Colors.black12,
          ),
        ],
      ),
      child: Icon(
        _icon,
        color: Colors.white,
        size: 18,
      ),
    );
  }
}
