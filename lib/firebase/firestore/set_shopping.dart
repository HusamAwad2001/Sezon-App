import 'package:sezon_app/core/storage/global.dart';
import 'package:sezon_app/firebase/fisestore_helper.dart';
import 'package:sezon_app/models/shopping_model.dart';

class SetShopping {
  static Future<bool> call(ShoppingModel shoppingModel) async {
    try {
      await FirestoreHelper.firestore
          .collection('users')
          .doc(Global.user['id'])
          .collection('shopping')
          .add(shoppingModel.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
