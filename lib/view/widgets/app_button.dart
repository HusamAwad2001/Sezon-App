import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_styles.dart';

import '../../core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.label,
      this.backgroundColor,
      this.textColor,
      this.style,
      this.prefix,
      required this.onPressed,
      this.width,
      this.vPadding = 13,
      this.hPadding = 0,
      this.borderRadius,
      this.borderColor = Colors.transparent,
      this.borderWidth = 1,
      this.elevation = 0.5,
      this.fontSize = 14});

  final String label;
  final Function() onPressed;
  final TextStyle? style;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double vPadding;
  final double hPadding;
  final double? borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final double fontSize;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: backgroundColor ?? AppColors.primaryColor,
      minWidth: width ?? Get.width,
      elevation: elevation,
      highlightElevation: 0,
      padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
        side: BorderSide(color: borderColor, width: borderWidth),
      ),
      child: prefix == null
          ? Text(
              label,
              style: style ?? getBoldStyle(color: Colors.white, fontSize: 14.sp),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                prefix!,
                SizedBox(width: 12.w),
                Text(
                  label,
                  style: style ?? TextStyle(color: textColor ?? Colors.white, fontSize: fontSize),
                ),
              ],
            ),
    );
  }
}
