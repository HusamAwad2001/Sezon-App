import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/user/requests_controller.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_strings.dart';
import '../../core/storage/global.dart';
import '../../firebase/firestore/set_shopping.dart';
import '../../models/product_model.dart';
import '../../models/radio_option.dart';
import '../../models/shopping_model.dart';
import '../../view/widgets/snack.dart';

class BuyNowController extends GetxController {
  String? paymentMethod;

  List<RadioOption> options = [
    RadioOption(AppStrings.visaCard, 1, image: AppImages.visa),
    RadioOption(AppStrings.masterCard, 2, image: AppImages.master),
    RadioOption(AppStrings.bankTransfer, 3, image: AppImages.bank),
  ];
  int selectedValue = 1;
  void setSelectedValue(int value) {
    selectedValue = value;
    update();
  }

  bool get isReady => address != null && paymentMethod != null && productDescription != null;

  confirmation() {
    if (address == null) {
      Snack().show(type: false, message: AppStrings.pleaseAddAddress);
      return;
    }
    if (paymentMethod == null) {
      Snack().show(type: false, message: AppStrings.pleaseChoosePaymentMethod);
      return;
    }
    if (productDescription == null) {
      Snack().show(type: false, message: AppStrings.pleaseAddProductDescription);
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
      Get.find<RequestsController>().getShopping();
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
      Snack().show(type: false, message: AppStrings.pleaseAddCountryName);
      return;
    }
    if (regionController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddRegionName);
      return;
    }
    if (cityController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddCityName);
      return;
    }
    if (streetController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddStreetName);
      return;
    }
    if (zipCodeController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddZipCode);
      return;
    }
    if (phoneController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddPhoneNumber);
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
      Snack().show(type: false, message: AppStrings.pleaseAddProductName);
      return;
    }
    if (productQuantityController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddProductQuantity);
      return;
    }
    if (productColorController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddProductColor);
      return;
    }
    if (productSizeController.text.isEmpty) {
      Snack().show(type: false, message: AppStrings.pleaseAddProductSize);
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
