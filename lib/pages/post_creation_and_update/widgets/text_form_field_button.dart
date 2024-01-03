import 'package:flutter/material.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFormFieldButton extends StatelessWidget {
  final Widget _child;
  final Color _backgroundColor;
  TextFormFieldButton({
    super.key,
    required Widget child,
    Color? backgroundColor,
  })  : _child = child,
        _backgroundColor = backgroundColor ?? CustomColors.lightBackGroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 11.w,
      height: 11.w,
      alignment: Alignment.center,
      child: _child,
    );
  }
}
