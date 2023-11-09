import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';

class ButtonGoOn extends StatelessWidget {
  final IconData? iconLeft;
  final double iconSize;
  final String title;
  final VoidCallback onPressed;
  const ButtonGoOn({
    this.iconLeft,
    this.iconSize = 48,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            if (iconLeft != null)
              Icon(
                iconLeft,
                color: CustomColors.primaryBlue,
                size: iconSize,
              ),
            SizedBox(width: 16),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primaryBlue,
                ),
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: CustomColors.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
