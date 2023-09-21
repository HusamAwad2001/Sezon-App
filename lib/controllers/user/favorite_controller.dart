import 'package:get/get.dart';
import 'package:sezon_app/models/product_model.dart';

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
        // print(favoritesList[item]['id']);
        // print(bookModel.id);
        isExist = true;
        index = item;
        break;
      }
    }
    if (isExist == false) {
      favoritesList.add(productModel.toJson());
      print(favoritesList.length);
      Storage.instance.write('favorites', favoritesList);
      update();
      return true;
    } else {
      // favoritesList.remove(bookModel.toJson());
      favoritesList.removeAt(index);
      print(favoritesList.length);
      Storage.instance.write('favorites', favoritesList);
      update();
      return false;
    }
  }

  deleteProduct(int index) {
    favoritesList.removeAt(index);
    Storage.instance.write('favorites', favoritesList);
    update();
  }
}
