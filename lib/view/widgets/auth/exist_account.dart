import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ExistAccount extends StatelessWidget {
  final String message;
  final String textButton;
  final Function() onTap;
  const ExistAccount({
    Key? key,
    required this.message,
    required this.textButton,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: getRegularStyle(fontSize: 14.sp),
        ),
        5.pw,
        GestureDetector(
          onTap: onTap,
          child: Text(
            textButton,
            style: getBoldStyle(
              fontSize: 14.sp,
              color: AppColors.primaryColor,
            ).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
              decorationThickness: 15,
            ),
          ),
        ),
      ],
    );
  }
}
