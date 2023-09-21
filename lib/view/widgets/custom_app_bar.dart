import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_styles.dart';

PreferredSize customAppBar({Widget? suffix, required String title, bool isBack = false}) {
  return PreferredSize(
    preferredSize: Size(Get.width, 80.h),
    child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.25),
              blurRadius: .5,
              offset: const Offset(0, .5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            !isBack
                ? SizedBox(
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                    ).paddingAll(10),
                  )
                : IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios).paddingAll(10),
                  ),
            Text(
              title,
              style: getBoldStyle(fontSize: 16.sp),
            ),
            suffix ??
                SizedBox(
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                  ).paddingAll(10),
                ),
          ],
        ),
      ),
    ),
  );
}
