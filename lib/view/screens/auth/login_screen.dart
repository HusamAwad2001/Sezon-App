import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/auth/login_controller.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/core/constants/app_styles.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/routes/routes.dart';
import 'package:sezon_app/view/widgets/app_button.dart';
import 'package:sezon_app/view/widgets/app_text_field.dart';
import 'package:sezon_app/view/widgets/auth/exist_account.dart';
import 'package:sezon_app/view/widgets/auth/image_clipper.dart';
import 'package:sezon_app/view/widgets/loading_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

class _BodyView extends GetView<LoginController> {
  const _BodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        280.ph,

        /// Login
        Text(
          AppStrings.login,
          style: getBoldStyle(fontSize: 23.sp),
        ),
        30.ph,

        /// Text Fields
        AppTextField(
          controller: controller.phoneController,
          textInputType: TextInputType.phone,
          hintText: AppStrings.hintPhoneNumber,
          label: AppStrings.phoneNumber,
          textColor: Colors.black,
        ),
        15.ph,
        AppTextField(
          controller: controller.passwordController,
          isPassword: true,
          hintText: AppStrings.hintPassword,
          label: AppStrings.password,
          textColor: Colors.black,
        ),
        5.ph,

        /// Forgot Password
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            AppStrings.forgotPassword,
            style: getRegularStyle(fontSize: 12.sp),
          ),
        ),
        35.ph,

        /// Button Login
        Obx(() {
          return controller.isLoading.value
              ? const LoadingWidget()
              : AppButton(
                  onPressed: () => controller.login(),
                  label: AppStrings.login,
                );
        }),
        38.ph,

        /// Exist Account
        ExistAccount(
          message: AppStrings.doNotHaveAnAccount,
          textButton: AppStrings.newAccount,
          onTap: () => Get.toNamed(Routes.registerScreen),
        ),
      ],
    ).paddingSymmetric(horizontal: 35.w);
  }
}
