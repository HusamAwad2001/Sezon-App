import 'package:get/get.dart';

import '../../controllers/user/buy_now_controller.dart';

class BuyNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyNowController>(() => BuyNowController());
  }
}
