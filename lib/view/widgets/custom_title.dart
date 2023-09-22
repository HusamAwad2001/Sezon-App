import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/empty_padding.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class CustomTitle extends StatelessWidget {
  final String title;

  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 5.w,
          height: 15.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        10.pw,
        Text(
          title,
          style: getMediumStyle(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
