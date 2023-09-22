import 'dart:io';

import '../fisestore_helper.dart';

import '../../models/product_model.dart';
import '../../view/widgets/snack.dart';
import '../storage_helper.dart';

class AddProduct {
  static Future<(String, bool)> call(
      ProductModel productModel, File fileImg) async {
    try {
      ({bool status, String url}) uploaded =
          await StorageHelper.instance.uploadImage('products', fileImg);
      if (uploaded.status) {
        productModel.imageUrl = uploaded.url;
        await FirestoreHelper.firestore
            .collection('products')
            .doc()
            .set(productModel.toJson())
            .then((_) {
          return (uploaded.url, true);
        }).catchError((_) {
          return ('', false);
        });
      }
      // return (uploaded.url, true);
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('Error: $e');
    }
    return ('', false);
  }
}
