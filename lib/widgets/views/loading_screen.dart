import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 218, 210, 1),
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
            color: CustomColors.primaryRed, size: 80),
      ),
    );
  }
}
