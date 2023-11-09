import 'package:flutter/cupertino.dart';

class CustomCupertinoDialogs {
  static Future<dynamic> showCupertinoBottomSheet({
    required BuildContext context,
    required List<CupertinoActionSheetAction> actions,
    required CupertinoActionSheetAction lastButton,
  }) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: actions,
        cancelButton: lastButton,
      ),
    );
  }
}
