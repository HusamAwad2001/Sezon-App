import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/shared_functions.dart';
import 'package:sezon_app/core/storage/storage.dart';
import 'package:sezon_app/firebase/auth_helper.dart';
import 'package:sezon_app/models/user_model.dart';

import '../../core/storage/global.dart';
import '../../routes/routes.dart';
import '../../view/widgets/snack.dart';

class RegisterController extends GetxController {
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  register() async {
    if (userNameController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال اسم المستخدم');
      return;
    }
    if (phoneController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال رقم الجوال');
      return;
    }
    if (passwordController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال كلمة المرور');
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال تأكيد كلمة المرور');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Snack().show(type: false, message: 'كلمة المرور غير متطابقة');
      return;
    }
    if (passwordController.text.length < 6) {
      Snack().show(type: false, message: 'كلمة المرور قصيرة جداً');
      return;
    }
    _validate();
    update();
  }

  RxBool isLoading = false.obs;

  _validate() {
    checkInternet(() async {
      isLoading.value = true;
      UserModel userModel = UserModel(
        userName: userNameController.text,
        phone: phoneController.text,
        password: generateMd5(passwordController.text),
      );
      bool isRegister = await FirebaseAuthHelper.instance.register(userModel: userModel);
      if (isRegister) {
        await Storage.instance.write('user', userModel.toJson());
        Storage.getData();
        Global.user['role'] == 'admin'
            ? Get.offAllNamed(Routes.adminNavigationScreen)
            : Get.offAllNamed(Routes.userNavigationScreen);
        clear();
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  clear() {
    userNameController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
