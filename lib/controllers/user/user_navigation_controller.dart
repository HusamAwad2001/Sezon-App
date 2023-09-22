import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_images.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/view/screens/user/navigaions/fragments/category_fragment.dart';
import 'package:sezon_app/view/screens/user/navigaions/fragments/favorite_fragment.dart';
import 'package:sezon_app/view/screens/user/navigaions/fragments/home_fragment.dart';
import 'package:sezon_app/view/screens/user/navigaions/fragments/requests_fragment.dart';

import '../../firebase/firestore/get_all_products.dart';
import '../../models/product_model.dart';

class UserNavigationController extends GetxController {
  int selectedIndex = 0;
  changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  List<Widget> fragments = [
    const HomeFragment(),
    const CategoryFragment(),
    const RequestsFragment(),
    const FavoriteFragment(),
  ];

  List<String> titleFragments = [
    AppStrings.home,
    AppStrings.categories,
    AppStrings.cart,
    AppStrings.favorite,
  ];

  int sectionIndex = 0;
  List<Map<String, dynamic>> tabsSections = [
    {
      'index': 1,
      'name': 'الخزف',
      'image': AppImages.category1,
    },
    {
      'index': 2,
      'name': 'الأكاليل',
      'image': AppImages.category2,
    },
    {
      'index': 3,
      'name': 'المطرزات',
      'image': AppImages.category3,
    },
    {
      'index': 4,
      'name': 'خشبيات',
      'image': AppImages.category4,
    },
    {
      'index': 5,
      'name': 'اكسسوارات',
      'image': AppImages.category5,
    },
  ];
  // List<String> tabsSections = [
  //   'الخزف',
  //   'الأكاليل',
  //   'المطرزات',
  //   'خشبيات',
  //   'اكسسوارات',
  // ];
  // List<String> tabsSectionsImage = [
  //   AppImages.category1,
  //   AppImages.category2,
  //   AppImages.category3,
  //   AppImages.category4,
  //   AppImages.category5,
  // ];

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
    (List<ProductModel>, bool) data = await GetAllProducts.call('');
    products = data.$1;
    status = data.$2;
    isLoading.value = false;
  }

  TextEditingController searchController = TextEditingController();
  List<ProductModel> searchedProducts = [];
  bool isSearching = false;
  search(String query) {
    searchedProducts = products
        .where((element) => element.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    update();
  }
}
