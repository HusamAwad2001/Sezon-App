import 'package:get/get.dart';
import 'package:sezon_app/controllers/auth/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
