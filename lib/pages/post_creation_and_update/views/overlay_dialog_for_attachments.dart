import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/helpers/utilities.dart';
import 'package:hippocapp/providers/attachments_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/styles/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OverlayDialogForAttachments extends ConsumerWidget {
  const OverlayDialogForAttachments({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 32.h,
            width: 100.w,
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                // buttons that appear to add attachments
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        ButtonForOverlay(
                          isTextBold: false,
                          text: 'Link',
                          backgroundColor: Colors.white,
                          imagePath: CustomIcons.linkIcon,
                          lateralMargin: 7,
                          onPressed: () {},
                        ),
                        ButtonForOverlay(
                          isTextBold: false,
                          text: 'PDF',
                          backgroundColor: Colors.white,
                          imagePath: CustomIcons.pdfIcon,
                          lateralMargin: 7,
                          onPressed: () {},
                        ),
                        ButtonForOverlay(
                          isTextBold: false,
                          text: 'Foto',
                          backgroundColor: Colors.white,
                          imagePath: CustomIcons.cameraIcon,
                          lateralMargin: 7,
                          onPressed: () async {
                            await ref
                                .read(attachmentsProvider.notifier)
                                .pickImageFromGallery();
                            for (var image
                                in ref.read(attachmentsProvider).images) {
                              var length = await image.file.length();
                              print(length);
                            }
                          },
                        ),
                        ButtonForOverlay(
                          isTextBold: false,
                          text: 'Immagini',
                          backgroundColor: Colors.white,
                          imagePath: CustomIcons.imageGalleryIcon,
                          lateralMargin: 7,
                          onPressed: () {},
                        ),
                      ]),
                      ButtonForOverlay(
                        isTextBold: true,
                        text: 'DOC',
                        backgroundColor: CustomColors.primaryYellow,
                        imagePath: CustomIcons.documentIcon,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonForOverlay(
                        isTextBold: false,
                        text: 'Entrata',
                        backgroundColor: CustomColors.inflowBackgroundColor,
                        imagePath: CustomIcons.inflowIcon,
                        lateralMargin: 7,
                        onPressed: () {},
                      ),
                      ButtonForOverlay(
                        isTextBold: false,
                        text: 'Uscita',
                        backgroundColor: CustomColors.outflowBackgroundColor,
                        imagePath: CustomIcons.outflowIcon,
                        lateralMargin: 7,
                        onPressed: () {},
                      ),
                      ButtonForOverlay(
                        isTextBold: true,
                        text: 'FIN',
                        backgroundColor: CustomColors.primaryYellow,
                        imagePath: CustomIcons.financeIcon,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 88),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: AnimatedRotation(
          duration: Duration(milliseconds: 1000),
          turns: 0.5,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.attach_file),
          ),
        ));
  }
}

class ButtonForOverlay extends StatelessWidget {
  Function onPressed;
  Color backgroundColor;
  String imagePath;
  String text;
  bool isTextBold;
  double lateralMargin;

  ButtonForOverlay({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.imagePath,
    required this.text,
    this.isTextBold = false,
    this.lateralMargin = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: lateralMargin, bottom: 16, left: lateralMargin),
      child: Column(
        children: [
          FloatingActionButton(
              child: Transform.scale(
                scale: 0.7,
                child: SvgPicture.asset(imagePath),
              ),
              backgroundColor: backgroundColor,
              onPressed: () {
                onPressed();
              }),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: isTextBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
