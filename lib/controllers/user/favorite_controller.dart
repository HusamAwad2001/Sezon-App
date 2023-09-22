import 'package:get/get.dart';
import '../../models/product_model.dart';

import '../../core/storage/global.dart';
import '../../core/storage/storage.dart';

class FavoriteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    favoritesList = Global.favorites;
  }

  List favoritesList = [];

  Future<bool> addOrDeleteProduct(ProductModel productModel) async {
    bool isExist = false;
    int index = 0;
    for (var item = 0; item < favoritesList.length; item++) {
      if (favoritesList[item]['id'] == productModel.id) {
        isExist = true;
        index = item;
        break;
      }
    }
    if (isExist == false) {
      addProduct(productModel);
      return true;
    } else {
      deleteProduct(index);
      return false;
    }
  }

  addProduct(ProductModel productModel) {
    favoritesList.add(productModel.toJson());
    Storage.instance.write('favorites', favoritesList);
    update();
  }

  deleteProduct(int index) {
    favoritesList.removeAt(index);
    Storage.instance.write('favorites', favoritesList);
    update();
  }
}
