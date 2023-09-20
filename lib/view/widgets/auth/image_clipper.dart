import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_images.dart';

class ImageClipper extends StatelessWidget {
  const ImageClipper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 300.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.clipperImage),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.topCenter,
      child: Image.asset(AppImages.appLogo, width: 70.w, height: 100.h).paddingOnly(top: 65.h),
    );
  }
}
