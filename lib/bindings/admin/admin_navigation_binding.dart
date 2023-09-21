import 'package:get/get.dart';
import 'package:sezon_app/controllers/admin/admin_navigation_controller.dart';

class AdminNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminNavigationController());
  }
}
