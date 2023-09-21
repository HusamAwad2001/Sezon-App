import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sezon_app/firebase/fisestore_helper.dart';
import 'package:sezon_app/models/product_model.dart';
import 'package:sezon_app/view/widgets/snack.dart';

import '../../core/constants/shared_functions.dart';
import '../../models/radio_option.dart';

class AddProductController extends GetxController {
  TextEditingController nameProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  TextEditingController imageProductController = TextEditingController();
  TextEditingController selectCategoryController = TextEditingController();

  int selectedValue = 1;
  List<RadioOption> options = [
    RadioOption('اكسسوارات', 1),
    RadioOption('المطرزات', 2),
    RadioOption('الخزف', 3),
    RadioOption('الأكاليل', 4),
    RadioOption('خشبيات', 5),
  ];

  void setSelectedValue(int value) {
    selectedValue = value;
    update();
  }

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  Future<void> pickImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageFile = File(_pickedFile!.path);
      imageProductController.text = extractImageName(_pickedFile!.name);
    }
    update();
  }

  void addProduct() {
    if (nameProductController.text.isEmpty) {
      Snack().show(type: false, message: 'من فضلك ادخل اسم المنتج');
      return;
    }
    if (descriptionProductController.text.isEmpty) {
      Snack().show(type: false, message: 'من فضلك ادخل وصف المنتج');
      return;
    }
    if (priceProductController.text.isEmpty) {
      Snack().show(type: false, message: 'من فضلك ادخل سعر المنتج');
      return;
    }
    if (imageProductController.text.isEmpty) {
      Snack().show(type: false, message: 'من فضلك اختر صورة المنتج');
      return;
    }
    if (selectCategoryController.text.isEmpty) {
      Snack().show(type: false, message: 'من فضلك اختر فئة المنتج');
      return;
    }

    _validate();
    update();
  }

  RxBool isLoading = false.obs;
  _validate() async {
    isLoading.value = true;
    ProductModel model = ProductModel(
      name: nameProductController.text,
      description: descriptionProductController.text,
      price: priceProductController.text.toString(),
      category: selectCategoryController.text,
    );
    await FirestoreHelper.instance.addProduct(model, imageFile!).then((_) => clear());
    isLoading.value = false;
  }

  clear() {
    nameProductController.clear();
    descriptionProductController.clear();
    priceProductController.clear();
    imageProductController.clear();
    selectCategoryController.clear();
  }
}
