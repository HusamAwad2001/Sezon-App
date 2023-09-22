import '../../core/storage/global.dart';
import '../fisestore_helper.dart';
import '../../models/shopping_model.dart';

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
