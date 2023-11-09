import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class FlashCustomDialog {
  static Future<void> showPopUp({
    required BuildContext context,
    required String text,
    bool isError = false,
  }) async {
    showFlash(
      context: context,
      duration: Duration(seconds: 4),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          backgroundColor: isError ? Colors.red : Colors.green,
          icon: null,
          content: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
