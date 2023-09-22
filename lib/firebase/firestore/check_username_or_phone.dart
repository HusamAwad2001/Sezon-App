import 'package:cloud_firestore/cloud_firestore.dart';

import '../../view/widgets/snack.dart';
import '../fisestore_helper.dart';

class CheckUserNameOrPhone {
  static Future<bool> call(String userName, String phone) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirestoreHelper.firestore
          .collection('users')
          .where('userName', isEqualTo: userName)
          .get();
      List documents = querySnapshot.docs;
      for (int i = 0; i < documents.length; i++) {
        if (documents[i].data()['userName'] == userName) {
          Snack().show(type: false, message: 'اسم المستخدم موجود مسبقاً');
          return true;
        }
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot2 = await FirestoreHelper.firestore
          .collection('users')
          .where('phone', isEqualTo: phone)
          .get();
      List documents2 = querySnapshot2.docs;
      for (int i = 0; i < documents2.length; i++) {
        if (documents2[i].data()['phone'] == phone) {
          Snack().show(type: false, message: 'رقم الهاتف موجود مسبقاً');
          return true;
        }
      }
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('error: $e');
    }
    return false;
  }
}
