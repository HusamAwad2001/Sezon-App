import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/admin/admin_navigation_controller.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/app_images.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/core/constants/app_styles.dart';
import 'package:sezon_app/routes/routes.dart';
import 'package:sezon_app/view/widgets/custom_app_bar.dart';

class AdminNavigationScreen extends StatelessWidget {
  const AdminNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AdminNavigationController());
    return GetBuilder(
      init: AdminNavigationController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customAppBar(title: controller.titleFragments[controller.selectedIndex]),
          body: IndexedStack(index: controller.selectedIndex, children: controller.fragments),
          floatingActionButton: _buildFloatingActionButton(controller),
          bottomNavigationBar: _buildBottomNavigationBar(controller),
        );
      },
    );
  }
}

/// Floating Action Button
Widget _buildFloatingActionButton(AdminNavigationController controller) {
  return controller.selectedIndex == 0
      ? FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.addProductScreen),
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          child: Icon(Icons.add, color: Colors.white, size: 30.w),
        )
      : const SizedBox();
}

/// Bottom Navigation Bar
Widget _buildBottomNavigationBar(AdminNavigationController controller) {
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
}
