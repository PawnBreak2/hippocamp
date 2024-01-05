import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocapp/constants/common.dart';
import 'package:hippocapp/pages/post_creation_and_update/widgets/top_bar_widgets/top_bar_post_detail_icon.dart';
import 'package:hippocapp/providers/posts_management/creation/post_creation_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/styles/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AlertDialogForPostAttributes extends ConsumerWidget {
  const AlertDialogForPostAttributes({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EdgeInsets contentPadding =
        EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h, bottom: 1.h);

    return AlertDialog(
      title: Center(
          child: Text('Attributi del post',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ))),
      content: Container(
        width: 100.w,
        height: 35.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (context, ref, child) {
                bool isImportant = ref.watch(
                    postCreationProvider.select((value) => value.important));
                return Padding(
                  padding: contentPadding,
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(postCreationProvider.notifier)
                          .setImportant(!isImportant);
                    },
                    child: SelectAttributeForPostItem(
                      icon: CustomMaterialIcons.important,
                      isActivated: isImportant,
                      text: 'Importante',
                    ),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                bool isUncertain = ref.watch(
                    postCreationProvider.select((value) => value.uncertain));
                return Padding(
                  padding: contentPadding,
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(postCreationProvider.notifier)
                          .setUncertain(!isUncertain);
                    },
                    child: SelectAttributeForPostItem(
                      icon: CustomMaterialIcons.uncertain,
                      isActivated: isUncertain,
                      text: 'Tentativo (impegno da confermare)',
                    ),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                bool isSensitive = ref.watch(postCreationProvider
                    .select((value) => value.sensitiveInfo));
                return Padding(
                  padding: contentPadding,
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(postCreationProvider.notifier)
                          .setSensitiveInfo(!isSensitive);
                    },
                    child: SelectAttributeForPostItem(
                      icon: CustomMaterialIcons.sensitive,
                      isActivated: isSensitive,
                      text: 'Privato (blurrato nella timeline)',
                    ),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                bool isSlot = ref.watch(postCreationProvider.select((value) =>
                    value.visualization ==
                    visualizationTypeMap[VisualizationType.slot]));
                bool isSpot = ref.watch(postCreationProvider.select((value) =>
                    value.visualization ==
                    visualizationTypeMap[VisualizationType.spot]));
                return Container(
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: CustomColors.grey121.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: contentPadding,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(postCreationProvider.notifier)
                                .setVisualizationType(VisualizationType.slot);
                          },
                          child: SelectAttributeForPostItem(
                            icon: CustomMaterialIcons.slot,
                            isActivated: isSlot,
                            text: 'Slot',
                          ),
                        ),
                      ),
                      Padding(
                        padding: contentPadding,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(postCreationProvider.notifier)
                                .setVisualizationType(VisualizationType.spot);
                          },
                          child: SelectAttributeForPostItem(
                            icon: CustomMaterialIcons.spot,
                            isActivated: isSpot,
                            text: 'Spot',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
      titlePadding: EdgeInsets.only(top: 2.h),
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      surfaceTintColor: CustomColors.grey121,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(25.w, 3.h),
            surfaceTintColor: Colors.white,
          ),
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: 15.sp,
              color: CustomColors.grey66,
            ),
          ),
          onPressed: () {
            context.pop(); // Dismiss alert dialog
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(25.w, 3.h),
            surfaceTintColor: Colors.white,
          ),
          child: Text(
            'Annulla',
            style: TextStyle(
              fontSize: 15.sp,
              color: CustomColors.grey66,
            ),
          ),
          onPressed: () {
            ref.read(postCreationProvider.notifier).resetAllPostAttributes();
            context.pop(); // Dismiss alert dialog
          },
        ),
      ],
    );
  }
}

class SelectAttributeForPostItem extends StatelessWidget {
  late bool _isActivated;
  late String _text;
  late IconData _icon;
  SelectAttributeForPostItem({
    required bool isActivated,
    required String text,
    required IconData icon,
    super.key,
  })  : _isActivated = isActivated,
        _text = text,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBarPostDetailIcon(
          backgroundColor:
              _isActivated ? CustomColors.primaryRed : CustomColors.grey121,
          icon: _icon,
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          _text,
          style: TextStyle(
              color: _isActivated ? Colors.black : CustomColors.grey121,
              fontSize: 14.sp,
              fontWeight: _isActivated ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
