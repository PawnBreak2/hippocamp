import 'package:flutter/scheduler.dart';

import '../../widgets/dialogs/flash_dialog.dart';

class PopUps {
  static showFlashErrorDialog({required context, required text}) {
    print('showing flash error dialog');
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      FlashCustomDialog.showPopUp(
        context: context,
        text: text,
        isError: true,
      );
    });
  }
}
