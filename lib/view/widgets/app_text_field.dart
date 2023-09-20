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
    this.labelSize,
    this.hintSize,
    this.backgroundColor,
    this.borderRadius = 5,
    this.borderColor,
    this.focusedBorderColor,
    this.isPassword = false,
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
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength = 255,
  });

  final String hintText;
  final String? label;
  final double? labelSize;
  final double? hintSize;
  final Color? backgroundColor;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? textColor;
  final bool isPassword;
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
      style: TextStyle(color: textColor ?? Colors.black, fontSize: labelSize ?? 14.sp),
      cursorColor: hintColor ?? AppColors.primaryColor,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: hintColor ?? AppColors.hintColor, fontSize: hintSize ?? 14.sp),
        hintText: hintText,
        labelStyle: getRegularStyle(
          color: AppColors.primaryColor,
          fontSize: 12.sp,
        ),
        // labelText: label,
        label: Text(
          label ?? '',
          style: getRegularStyle(
            color: AppColors.primaryColor,
            fontSize: 12.sp,
          ),
        ).paddingSymmetric(horizontal: 8.w),
        counter: const SizedBox.shrink(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: const BorderSide(color: AppColors.hintColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: const BorderSide(color: AppColors.primaryColor)),
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
