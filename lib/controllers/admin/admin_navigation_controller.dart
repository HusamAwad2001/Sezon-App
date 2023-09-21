import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/firebase/firestore/get_all_products.dart';
import 'package:sezon_app/models/product_model.dart';
import 'package:sezon_app/view/screens/admin/navigaions/fragments/home_fragment.dart';
import 'package:sezon_app/view/screens/admin/navigaions/fragments/notifications_fragment.dart';
import 'package:sezon_app/view/screens/admin/navigaions/fragments/profile_fragment.dart';
import 'package:sezon_app/view/screens/admin/navigaions/fragments/sales_fragment.dart';

class AdminNavigationController extends GetxController {
  int selectedIndex = 0;
  changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  List<Widget> fragments = [
    const HomeFragment(),
    const SalesFragment(),
    const NotificationsFragment(),
    const ProfileFragment(),
  ];

  List<String> titleFragments = [
    AppStrings.home,
    AppStrings.sales,
    AppStrings.notifications,
    AppStrings.profile,
  ];

  int sectionIndex = 0;
  List<String> tabsSections = [
    'اكسسوارات',
    'المطرزات',
    'الخزف',
    'الأكاليل',
    'خشبيات',
  ];

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }

  List<ProductModel> products = [];
  late bool status;
  RxBool isLoading = false.obs;
  getAllProducts() async {
    isLoading.value = true;
    (List<ProductModel>, bool) data = await GetAllProducts.call(tabsSections[sectionIndex]);
    products = data.$1;
    status = data.$2;
    isLoading.value = false;
  }

  TextEditingController searchController = TextEditingController();
  List<ProductModel> searchedProducts = [];
  bool isSearching = false;
  search(String query) {
    searchedProducts = products.where((element) => element.name.startsWith(query)).toList();
    update();
  }
}
