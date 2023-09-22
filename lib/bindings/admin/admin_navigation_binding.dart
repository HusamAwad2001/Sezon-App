import 'package:get/get.dart';
import '../../controllers/admin/admin_navigation_controller.dart';

class AdminNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminNavigationController());
  }
}
