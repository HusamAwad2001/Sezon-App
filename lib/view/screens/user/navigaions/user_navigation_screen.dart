import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/view/widgets/custom_app_bar.dart';

import '../../../../controllers/user/user_navigation_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';

class UserNavigationScreen extends GetView<UserNavigationController> {
  const UserNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserNavigationController>(
      init: UserNavigationController(),
      builder: (controller) {
        return Scaffold(
          // backgroundColor: AppColors.greyColor4,
          appBar: customAppBar(
            title: controller.titleFragments[controller.selectedIndex],
            prefix:
                Image.asset(AppImages.avatar, width: 30.w, height: 30.h).paddingOnly(right: 24.w),
            suffix: Image.asset(AppImages.notification, width: 24.w, height: 24.h)
                .paddingOnly(left: 24.w),
          ),
          body: IndexedStack(index: controller.selectedIndex, children: controller.fragments),
          bottomNavigationBar: BottomNavigationBar(
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

              /// Category
              BottomNavigationBarItem(
                icon: Image.asset(AppImages.category, width: 23.w, height: 23.h),
                activeIcon: Image.asset(
                  AppImages.category,
                  width: 23.w,
                  height: 23.h,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.categories,
              ),

              /// Cart
              BottomNavigationBarItem(
                icon: Image.asset(AppImages.cart, width: 23.w, height: 23.h),
                activeIcon: Image.asset(
                  AppImages.cart,
                  width: 23.w,
                  height: 23.h,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.cart,
              ),

              /// Profile
              BottomNavigationBarItem(
                icon: Image.asset(AppImages.favorite, width: 23.w, height: 23.h),
                activeIcon: Image.asset(
                  AppImages.favorite,
                  width: 23.w,
                  height: 23.h,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.favorite,
              ),
            ],
          ),
        );
      },
    );
  }
}
