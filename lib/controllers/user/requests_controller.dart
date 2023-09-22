import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/models/shopping_model.dart';

import '../../firebase/firestore/get_all_shopping.dart';

class RequestsController extends GetxController {
  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    getShopping();
  }

  List<String> tabsSections = [AppStrings.shoppingPending, AppStrings.shoppingAccepted];
  late bool status;
  RxBool isLoading = false.obs;

  List<ShoppingModel> myRequests = [];
  getShopping() async {
    isLoading.value = true;
    (bool, List<ShoppingModel>) result = await GetAllShopping.call(
      selectedIndex == 0 ? false : true,
    );
    status = result.$1;
    myRequests = result.$2;
    isLoading.value = false;
    update();
  }
}
