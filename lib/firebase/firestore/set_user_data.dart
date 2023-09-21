import 'package:sezon_app/firebase/firestore/check_username_or_phone.dart';

import '../../models/user_model.dart';
import '../../view/widgets/snack.dart';
import 'fisestore_helper.dart';

class SetUserData {
  static Future<bool> call(UserModel userModel) async {
    try {
      bool isExist = await CheckUserNameOrPhone.call(userModel.userName, userModel.phone);
      if (isExist) {
        return false;
      } else {
        await FirestoreHelper.firestore.collection('users').doc().set(userModel.toJson());
        return true;
      }
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('Error: $e');
      return false;
    }
  }
}
