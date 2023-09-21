import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
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

  List<String> tabsSections = [
    'المنتجات',
    'المطرزات',
    'الأكاليل',
    'الخزف',
    'اكسسوارات',
  ];
}
