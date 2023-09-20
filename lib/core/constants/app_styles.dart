import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_strings.dart';

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontFamily: AppStrings.fontFamily,
    color: color,
    fontWeight: fontWeight,
    // decoration: isUnderLine != null
    //     ? isUnderLine
    //         ? TextDecoration.underline
    //         : TextDecoration.none
    //     : TextDecoration.none,
  );
}

TextStyle getRegularStyle({double fontSize = 18, Color color = Colors.black}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.regular, color);
}

TextStyle getMediumStyle({double fontSize = 18, Color color = Colors.black}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.medium, color);
}

TextStyle getLightStyle({double fontSize = 18, Color color = Colors.black}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.light, color);
}

TextStyle getBoldStyle({double fontSize = 18, Color color = Colors.black}) {
  return _getTextStyle(
    fontSize.sp,
    FontWeightManager.bold,
    color,
  );
}

TextStyle getSemiBoldStyle({double fontSize = 18, Color color = Colors.black}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.semiBold, color);
}
