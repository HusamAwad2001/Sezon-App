import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_images.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/firebase/firestore/set_shopping.dart';
import 'package:sezon_app/models/product_model.dart';
import 'package:sezon_app/models/shopping_model.dart';
import 'package:sezon_app/view/widgets/snack.dart';

import '../../core/storage/global.dart';
import '../../models/radio_option.dart';

class BuyNowController extends GetxController {
  String? paymentMethod;

  List<RadioOption> options = [
    RadioOption('بطاقة الفيزا', 1, image: AppImages.visa),
    RadioOption('بطاقة ماستركارد', 2, image: AppImages.master),
    RadioOption('تحويل بنكي', 3, image: AppImages.bank),
  ];
  int selectedValue = 1;
  void setSelectedValue(int value) {
    selectedValue = value;
    update();
  }

  bool get isReady => address != null && paymentMethod != null && productDescription != null;

  confirmation() {
    if (address == null) {
      Snack().show(type: false, message: 'يرجى إضافة عنوان');
      return;
    }
    if (paymentMethod == null) {
      Snack().show(type: false, message: 'يرجى اختيار طريقة الدفع');
      return;
    }
    if (productDescription == null) {
      Snack().show(type: false, message: 'يرجى إضافة مواصفات المنتج');
      return;
    }
    validate();
    update();
  }

  RxBool isLoaded = false.obs;
  validate() async {
    isLoaded.value = true;
    ShoppingModel model = ShoppingModel(
      id: '',
      userId: Global.user['id'],
      address: address!,
      paymentMethod: paymentMethod!,
      productDescription: productDescription!,
      isAgree: false,
      product: Get.arguments as ProductModel,
    );
    bool result = await SetShopping.call(model);
    if (result) {
      Get.back();
      Snack().show(type: true, message: AppStrings.successSendRequest);
    } else {
      Snack().show(type: false, message: AppStrings.somethingWentWrong);
    }
    isLoaded.value = false;
  }

  final countryController = TextEditingController();
  final regionController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneController = TextEditingController();
  String? address;

  addAddress() {
    if (countryController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال اسم الدولة');
      return;
    }
    if (regionController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال اسم المنطقة');
      return;
    }
    if (cityController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال اسم المدينة');
      return;
    }
    if (streetController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال اسم الشارع');
      return;
    }
    if (zipCodeController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال اسم الرمز البريدي');
      return;
    }
    if (phoneController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال رقم الهاتف');
      return;
    }
    address =
        '${countryController.text}, ${regionController.text}, ${cityController.text}, ${streetController.text}, ${zipCodeController.text}, ${phoneController.text}';
    Get.back();
    countryController.clear();
    regionController.clear();
    cityController.clear();
    streetController.clear();
    zipCodeController.clear();
    phoneController.clear();
    update();
  }

  final productTitleController = TextEditingController();
  final productQuantityController = TextEditingController();
  final productColorController = TextEditingController();
  final productSizeController = TextEditingController();
  String? productDescription;

  addDescription() {
    if (productTitleController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال اسم المنتج');
      return;
    }
    if (productQuantityController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال كمية المنتج');
      return;
    }
    if (productColorController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال لون المنتج');
      return;
    }
    if (productSizeController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى ادخال حجم المنتج');
      return;
    }
    productDescription =
        '${productTitleController.text}، \nالكمية : ${productQuantityController.text} قطع، \nاللون : ${productColorController.text}، \nالحجم : ${productSizeController.text}';
    productTitleController.clear();
    productQuantityController.clear();
    productColorController.clear();
    productSizeController.clear();
    update();
  }
}
