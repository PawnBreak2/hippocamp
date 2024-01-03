import 'package:flutter/material.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/styles/icons.dart';

class ImportantIconOverlay extends StatelessWidget {
  const ImportantIconOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: CustomColors.primaryRed,
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
        CustomMaterialIcons.important,
        color: Colors.white,
        size: 12,
      ),
    );
  }
}
