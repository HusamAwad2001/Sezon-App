import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sezon_app/firebase/firestore/fisestore_helper.dart';

import '../../models/product_model.dart';

class GetAllProducts {
  static Future<(List<ProductModel> products, bool status)> call(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirestoreHelper.firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
          await FirestoreHelper.firestore.collection('products').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          category == '' ? querySnapshot2.docs : querySnapshot.docs;
      List<ProductModel>? details = documents.map((e) {
        ProductModel productModel = ProductModel.fromJson(e.data());
        productModel.id = e.id;
        return productModel;
      }).toList();
      return (details, true);
    } catch (e) {
      print('error: $e');
      return ([].cast<ProductModel>(), false);
    }
  }
}
