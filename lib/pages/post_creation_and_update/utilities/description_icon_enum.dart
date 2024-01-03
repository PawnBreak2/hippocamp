import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/constants/common.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum InsertDescriptionButtonState {
  openWithText,
  closedWithText,
  openWithoutText,
  closedWithoutText,
}

Map<InsertDescriptionButtonState, Widget> insertDescriptionButtonStateMap = {
  InsertDescriptionButtonState.openWithText: SvgPicture.asset(
    Constants.iconAssetsPath + 'NotaConTestoAperta.svg',
    width: 8.w,
    height: 8.w,
  ),
  InsertDescriptionButtonState.closedWithText: SvgPicture.asset(
    Constants.iconAssetsPath + 'NotaConTestoChiusa.svg',
    width: 8.w,
    height: 8.w,
  ),
  InsertDescriptionButtonState.openWithoutText: SvgPicture.asset(
    Constants.iconAssetsPath + 'NotaVuotaAperta.svg',
    width: 8.w,
    height: 8.w,
  ),
  InsertDescriptionButtonState.closedWithoutText: SvgPicture.asset(
    Constants.iconAssetsPath + 'NotaVuotaChiusa.svg',
    width: 8.w,
    height: 8.w,
  ),
};
