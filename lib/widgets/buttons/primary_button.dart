import 'package:flutter/material.dart';
import 'package:hippocapp/styles/colors.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final String title;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  const PrimaryButton({
    required this.title,
    this.child,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          backgroundColor ?? CustomColors.primaryBlue,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child ??
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ],
      ),
    );
  }
}
