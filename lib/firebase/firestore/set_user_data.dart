import 'package:sezon_app/firebase/firestore/check_username_or_phone.dart';
import 'package:uuid/uuid.dart';

import '../../models/user_model.dart';
import '../../view/widgets/snack.dart';
import '../fisestore_helper.dart';

class SetUserData {
  static final String _uuid = const Uuid().v4();
  static Future<bool> call(UserModel userModel) async {
    try {
      bool isExist = await CheckUserNameOrPhone.call(userModel.userName, userModel.phone);
      if (isExist) {
        return false;
      } else {
        userModel.id = _uuid;
        await FirestoreHelper.firestore.collection('users').doc(_uuid).set(userModel.toJson());
        return true;
      }
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('Error: $e');
      return false;
    }
  }
}
