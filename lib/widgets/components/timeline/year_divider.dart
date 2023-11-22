import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class YearDivider extends StatelessWidget {
  const YearDivider({
    super.key,
    required this.year,
  });

  final String year;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.darkerGrey,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: CustomColors.lightGrey,
            ),
            height: 4.h,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "${year}",
                style: TextStyle(
                    color: CustomColors.primaryRed,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
