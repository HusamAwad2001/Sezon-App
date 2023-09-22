import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sezon_app/core/storage/global.dart';
import 'package:sezon_app/models/shopping_model.dart';

import '../fisestore_helper.dart';

class GetAllShopping {
  static Future<(bool, List<ShoppingModel>)> call(bool isAgree) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirestoreHelper.firestore
          .collection('users')
          .doc(Global.user['id'])
          .collection('shopping')
          .where('isAgree', isEqualTo: isAgree)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
      List<ShoppingModel>? details = documents.map((e) {
        ShoppingModel productModel = ShoppingModel.fromJson(e.data());
        return productModel;
      }).toList();
      return (true, details);
    } catch (e) {
      return (false, [].cast<ShoppingModel>());
    }
  }
}
