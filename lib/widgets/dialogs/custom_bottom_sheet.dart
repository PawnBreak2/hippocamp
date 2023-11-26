import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/styles/colors.dart';

class CustomBottomSheet {
  static Future<dynamic> showDraggableBottomSheet(
    BuildContext context,
    Widget Function(ScrollController controller) child, {
    Color? appBarColor,
    bool showCloserIcon = true,
    double initialChildSize = .94,
    double maxChildSize = .94,
    double minChildSize = .93,
    bool scrollable = true,
    bool touchToClose = false,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: scrollable,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        maxChildSize: maxChildSize,
        minChildSize: minChildSize,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: appBarColor ?? CustomColors.pinkWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () => touchToClose ? Navigator.pop(context) : null,
              child: Stack(
                children: [
                  child(controller),

                  // Closer icon
                  if (showCloserIcon)
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.only(top: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.clear,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<dynamic> showFullDialog(
    BuildContext context,
    Widget child,
  ) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: child,
          ),
        ),
      ),
    );
  }
}
