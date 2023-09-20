import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon_app/view/widgets/snack.dart';

import '../../core/constants/md5_encrypt.dart';
import '../../firebase/auth_helper.dart';
import '../../models/user_model.dart';
import '../../routes/routes.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
    if (phoneController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال رقم الهاتف');
      return;
    }
    if (passwordController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال كلمة المرور');
      return;
    }
    if (passwordController.text.length < 6) {
      Snack().show(type: false, message: 'كلمة المرور قصيرة جداً');
      return;
    }
    _validate();
  }

  RxBool isLoading = false.obs;

  _validate() {
    checkInternet(() async {
      isLoading.value = true;
      UserModel userModel = UserModel(
        id: '',
        userName: '',
        phone: phoneController.text,
        password: generateMd5(passwordController.text),
      );
      bool isLoggedIn = await FirebaseAuthHelper.instance.login(userModel: userModel);
      if (isLoggedIn) {
        Get.offAllNamed(Routes.navigationScreen);
        clear();
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  clear() {
    phoneController.clear();
    passwordController.clear();
  }
}
