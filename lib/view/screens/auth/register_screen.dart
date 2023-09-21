import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/auth/register_controller.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/core/constants/app_styles.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/view/widgets/app_button.dart';
import 'package:sezon_app/view/widgets/app_text_field.dart';
import 'package:sezon_app/view/widgets/auth/exist_account.dart';
import 'package:sezon_app/view/widgets/auth/image_clipper.dart';
import 'package:sezon_app/view/widgets/loading_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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

class _BodyView extends GetView<RegisterController> {
  const _BodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          280.ph,

          /// Register
          Text(
            AppStrings.createNewAccount,
            style: getBoldStyle(fontSize: 23.sp),
          ),
          30.ph,

          /// Text Fields
          AppTextField(
            controller: controller.userNameController,
            hintText: AppStrings.hintUserName,
            label: AppStrings.userName,
            textColor: Colors.black,
          ),
          15.ph,
          AppTextField(
            controller: controller.phoneController,
            textInputType: TextInputType.phone,
            hintText: AppStrings.hintPhoneNumber,
            label: AppStrings.phoneNumber,
            textColor: Colors.black,
          ),
          15.ph,
          AppTextField(
            isPassword: true,
            controller: controller.passwordController,
            hintText: AppStrings.hintPassword,
            label: AppStrings.password,
            textColor: Colors.black,
          ),
          15.ph,
          AppTextField(
            isPassword: true,
            controller: controller.confirmPasswordController,
            hintText: AppStrings.hintPassword,
            label: AppStrings.confirmPassword,
            textColor: Colors.black,
          ),
          30.ph,

          /// Button Register
          Obx(() {
            return controller.isLoading.value
                ? const LoadingWidget()
                : AppButton(
                    onPressed: () => controller.register(),
                    label: AppStrings.register,
                  );
          }),
          38.ph,

          /// Exist Account
          ExistAccount(
            message: AppStrings.doYouHaveAnAccount,
            textButton: AppStrings.login,
            onTap: () => Get.back(),
          ),
        ],
      ).paddingSymmetric(horizontal: 35.w),
    );
  }
}
