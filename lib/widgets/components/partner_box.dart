import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PartnerBox extends StatelessWidget {
  final String iconUrl;
  final double width;
  final double height;
  final EdgeInsets? margin;
  final Color backgroundColor;
  final Color borderColor;
  const PartnerBox({
    required this.iconUrl,
    required this.width,
    required this.height,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.black,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.zero,
      child: iconUrl.isEmpty
          ? SizedBox()
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SvgPicture.network(
                iconUrl,
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}
