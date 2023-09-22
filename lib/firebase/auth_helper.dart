import 'firestore/get_all_users.dart';
import 'firestore/set_user_data.dart';
import '../models/user_model.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final instance = FirebaseAuthHelper._();

  Future<bool> register({required UserModel userModel}) async {
    try {
      bool isExist = await SetUserData.call(userModel);
      return isExist;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> login({required UserModel userModel}) async {
    try {
      bool isLoggedIn = await GetAllUsers.call(
        phone: userModel.phone,
        password: userModel.password,
      );
      return isLoggedIn;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Future<void> sendVerificationCode(String phoneNumber) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       // This callback will be triggered automatically in certain cases,
  //       // such as when the verification is done without user interaction.
  //       // You can use credential to sign in the user.
  //       print('Verification completed: $credential');
  //     },
  //     verificationFailed: (FirebaseAuthException exception) {
  //       // This callback will be triggered if the verification fails.
  //       print('Verification failed: ${exception.code}');
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       // This callback will be triggered when the verification code is successfully sent.
  //       // You can save the verificationId and use it to build a credential.
  //       print('Verification code sent: $verificationId');
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // This callback will be triggered when the automatic code retrieval times out.
  //       // You can use verificationId to manually retrieve the code.
  //       print('Code retrieval timeout: $verificationId');
  //     },
  //   );
  // }
}
