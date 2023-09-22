import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_images.dart';
import '../../core/storage/storage.dart';
import '../../routes/routes.dart';

import '../../core/storage/global.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  _start() async {
    await Future.delayed(3.seconds, () {
      !(Storage.instance.hasData('user'))
          ? Get.offNamed(Routes.loginScreen)
          : Global.user['role'] == 'admin'
              ? Get.offNamed(Routes.adminNavigationScreen)
              : Get.offNamed(Routes.userNavigationScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    _start();
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bgSplash),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Image.asset(AppImages.appLogo, height: 209.h),
      ),
    );
  }
}
