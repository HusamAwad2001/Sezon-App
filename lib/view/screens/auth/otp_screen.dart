import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../controllers/auth/otp_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/empty_padding.dart';
import '../../widgets/app_button.dart';
import '../../widgets/auth/image_clipper.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Hero(
            tag: 'ImageClipper',
            child: ImageClipper(),
          ),
          _BodyView(),
        ],
      ),
    );
  }
}

class _BodyView extends GetView<OtpController> {
  const _BodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        280.ph,

        /// Verification Code
        Text(
          AppStrings.verificationCode,
          style: getBoldStyle(fontSize: 23.sp),
        ),
        40.ph,
        Text(
          '${AppStrings.descriptionOtp} ${Get.arguments}',
          textAlign: TextAlign.center,
          style: getMediumStyle(fontSize: 14.sp),
        ),
        27.ph,

        /// PinPut
        Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                controller: controller.pinController,
                focusNode: controller.focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: controller.defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22.w,
                      height: 1,
                      color: controller.focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: controller.defaultPinTheme.copyWith(
                  decoration: controller.defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: controller.focusedBorderColor),
                  ),
                ),
                submittedPinTheme: controller.defaultPinTheme.copyWith(
                  decoration: controller.defaultPinTheme.decoration!.copyWith(
                    color: controller.fillColor,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: controller.focusedBorderColor),
                  ),
                ),
                errorPinTheme: controller.defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     focusNode.unfocus();
              //     formKey.currentState!.validate();
              //   },
              //   child: const Text('Validate'),
              // ),
            ],
          ),
        ),
        90.ph,

        /// Button Verify
        AppButton(
          onPressed: () => controller.otp(),
          label: AppStrings.send,
        ),
      ],
    ).paddingSymmetric(horizontal: 35.w);
  }
}
