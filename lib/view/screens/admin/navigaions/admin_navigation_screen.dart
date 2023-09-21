import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/admin/admin_navigation_controller.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/app_images.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/core/constants/app_styles.dart';
import 'package:sezon_app/routes/routes.dart';

class AdminNavigationScreen extends GetView<AdminNavigationController> {
  const AdminNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 80.h),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  blurRadius: .5,
                  offset: const Offset(0, .5),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: GetBuilder<AdminNavigationController>(
              builder: (_) {
                return Text(
                  controller.titleFragments[controller.selectedIndex],
                  style: getBoldStyle(fontSize: 16.sp),
                );
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<AdminNavigationController>(
        builder: (_) {
          return IndexedStack(
            index: controller.selectedIndex,
            children: controller.fragments,
          );
        },
      ),
      floatingActionButton: controller.selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => Get.toNamed(Routes.addProductScreen),
              shape: const CircleBorder(),
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              child: Icon(Icons.add, color: Colors.white, size: 30.w),
            )
          : const SizedBox(),
      bottomNavigationBar: GetBuilder<AdminNavigationController>(
        builder: (_) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: controller.selectedIndex,
            onTap: (index) => controller.changeIndex(index),
            selectedItemColor: AppColors.primaryColor,
            selectedLabelStyle: getBoldStyle(fontSize: 10.sp),
            unselectedLabelStyle: getMediumStyle(fontSize: 8.sp),
            items: [
              /// Home
              BottomNavigationBarItem(
                icon: Image.asset(AppImages.home, width: 23.w, height: 23.h),
                activeIcon: Image.asset(
                  AppImages.home,
                  width: 25.w,
                  height: 25.h,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.home,
              ),

              /// Sales
              BottomNavigationBarItem(
                icon: Image.asset(AppImages.sales, width: 23.w, height: 23.h),
                activeIcon: Image.asset(
                  AppImages.sales,
                  width: 23.w,
                  height: 23.h,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.sales,
              ),

              /// Notifications
              BottomNavigationBarItem(
                icon: Image.asset(AppImages.notification, width: 23.w, height: 23.h),
                activeIcon: Image.asset(
                  AppImages.notification,
                  width: 23.w,
                  height: 23.h,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.notifications,
              ),

              /// Profile
              BottomNavigationBarItem(
                icon: Image.asset(AppImages.profile, width: 23.w, height: 23.h),
                activeIcon: Image.asset(
                  AppImages.profile,
                  width: 23.w,
                  height: 23.h,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.profile,
              ),
            ],
          );
        },
      ),
    );
  }
}
