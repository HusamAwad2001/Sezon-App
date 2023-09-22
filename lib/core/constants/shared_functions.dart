import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/view/widgets/custom_title.dart';

import '../../view/widgets/snack.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

void checkInternet(Function() function) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      function();
    }
  } on SocketException catch (_) {
    Snack().show(type: false, message: 'لا يوجد اتصال بالانترنت');
  }
}

String extractImageName(String path) {
  List<String> parts = path.split('.');
  parts.removeLast();
  String imageName = parts.last;
  return imageName;
}

void openBottomSheet(String title, Widget child) {
  Get.bottomSheet(
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: Get.width),
        Container(
          width: 60.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: AppColors.greyColor3,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        30.ph,
        CustomTitle(title: title),
        child,
      ],
    ).paddingSymmetric(vertical: 30.h, horizontal: 26.w),
    isScrollControlled: true,
    elevation: 0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30.r),
        topLeft: Radius.circular(30.r),
      ),
    ),
  );
}
