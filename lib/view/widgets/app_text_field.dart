import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/app_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.label,
    this.fontSize,
    this.hintSize,
    this.labelStyle,
    this.backgroundColor,
    this.borderRadius = 5,
    this.enableBorderColor,
    this.focusBorderColor,
    this.focusedBorderColor,
    this.isPassword = false,
    this.isEnabled = true,
    this.controller,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.vPadding = 15,
    this.hPadding = 15,
    this.prefix,
    this.hintColor,
    this.cursorColor,
    this.textColor,
    this.suffix,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength = 255,
  });

  final String hintText;
  final String? label;
  final double? fontSize;
  final double? hintSize;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final double borderRadius;
  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? focusedBorderColor;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? textColor;
  final bool isPassword;
  final bool isEnabled;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final double vPadding;
  final double hPadding;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      maxLines: isPassword ? 1 : maxLines,
      minLines: isPassword ? 1 : minLines,
      maxLength: maxLength,
      controller: controller ?? TextEditingController(),
      textInputAction: textInputAction,
      keyboardType: textInputType,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChanged,
      style: TextStyle(color: textColor ?? Colors.black, fontSize: fontSize ?? 14.sp),
      cursorColor: hintColor ?? AppColors.primaryColor,
      decoration: InputDecoration(
        enabled: isEnabled,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(color: hintColor ?? AppColors.hintColor, fontSize: hintSize ?? 11.sp),
        hintText: hintText,
        labelStyle: getRegularStyle(
          color: AppColors.primaryColor,
          fontSize: 12.sp,
        ),
        // labelText: label,
        label: label != null
            ? Text(
                label!,
                style: labelStyle ??
                    getRegularStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                    ),
              ).paddingSymmetric(horizontal: 5.w)
            : null,
        counter: const SizedBox.shrink(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: enableBorderColor ?? AppColors.hintColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: enableBorderColor ?? AppColors.hintColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(color: focusBorderColor ?? AppColors.primaryColor)),
        filled: true,
        prefixIcon: prefix == null
            ? const SizedBox()
            : Container(
                width: kMinInteractiveDimension,
                height: kMinInteractiveDimension,
                alignment: Alignment.center,
                child: prefix,
              ),
        prefixIconConstraints: prefix == null
            ? BoxConstraints(minWidth: vPadding)
            : Theme.of(context).visualDensity.effectiveConstraints(
                  const BoxConstraints(
                    minWidth: kMinInteractiveDimension,
                    minHeight: kMinInteractiveDimension,
                  ),
                ),
        suffixIcon: suffix == null
            ? const SizedBox()
            : Container(
                width: kMinInteractiveDimension,
                height: kMinInteractiveDimension,
                alignment: Alignment.center,
                child: suffix,
              ),
        suffixIconConstraints: suffix == null
            ? BoxConstraints(minWidth: vPadding)
            : Theme.of(context).visualDensity.effectiveConstraints(
                  const BoxConstraints(
                    minWidth: kMinInteractiveDimension,
                    minHeight: kMinInteractiveDimension,
                  ),
                ),
        contentPadding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
        fillColor: backgroundColor ?? Colors.white,
        isDense: true,
      ),
    );
  }
}
