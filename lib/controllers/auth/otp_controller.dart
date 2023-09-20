import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sezon_app/view/widgets/snack.dart';

import '../../core/constants/app_colors.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final fillColor = Colors.white;
  final focusedBorderColor = AppColors.primaryColor;
  final defaultPinTheme = PinTheme(
    width: 46.w,
    height: 46.h,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.r),
      border: Border.all(color: AppColors.greyColor),
    ),
  );

  otp() async {
    if (pinController.text.length != 4) {
      Snack().show(type: false, message: 'يرجى إدخال رمز التحقق');
      return;
    }
    _validate();
  }

  _validate() async {
    Get.offAllNamed('/home');
    clear();
  }

  clear() => pinController.clear();
}
