import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sezon_app/core/constants/app_colors.dart';

class CustomRadio extends StatelessWidget {
  int value;
  int groupValue;
  Color? color;
  Color? selectedColor;

  CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.color = Colors.grey,
    this.selectedColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: value == groupValue ? selectedColor : color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: value == groupValue
          ? Icon(Icons.check, color: Colors.white, size: 15.w)
          : const SizedBox(),
    );
  }
}
