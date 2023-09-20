import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_images.dart';
import 'package:sezon_app/core/storage/storage.dart';
import 'package:sezon_app/routes/routes.dart';

import '../../core/storage/global.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  _start() async {
    await Future.delayed(3.seconds, () {
      print(Global.user['role'] == 'user');
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
