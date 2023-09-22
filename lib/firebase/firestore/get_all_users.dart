import 'package:cloud_firestore/cloud_firestore.dart';
import '../fisestore_helper.dart';

import '../../core/storage/storage.dart';
import '../../models/user_model.dart';
import '../../view/widgets/snack.dart';

class GetAllUsers {
  static Future<bool> call(
      {required String phone, required String password}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirestoreHelper
          .firestore
          .collection('users')
          .where('phone', isEqualTo: phone)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          querySnapshot.docs;
      if (documents.isEmpty) {
        Snack().show(type: false, message: 'رقم الهاتف غير صحيح');
        return false;
      }

      if (documents[0].data()['phone'] == phone) {
        if (documents[0].data()['password'] == password) {
          UserModel userModel = UserModel.fromJson(documents[0].data());
          userModel.id = documents[0].id;
          Storage.instance.write('user', userModel.toJson());
          return true;
        } else {
          Snack().show(type: false, message: 'كلمة المرور غير صحيحة');
          return false;
        }
      } else {
        Snack().show(type: false, message: 'رقم الهاتف غير صحيح');
        return false;
      }
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('error: $e');
    }
    return false;
  }
}
