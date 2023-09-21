import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/admin/admin_navigation_controller.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/app_images.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/view/widgets/app_text_field.dart';

import '../../../../../core/constants/app_styles.dart';

class HomeFragment extends GetView<AdminNavigationController> {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Search Bar
        AppTextField(
          hintText: AppStrings.hintSearch,
          hintColor: AppColors.greyColor2,
          borderRadius: 10.r,
          backgroundColor: Colors.black.withOpacity(0.04),
          enableBorderColor: Colors.transparent,
          focusBorderColor: Colors.transparent,
          prefix: SvgPicture.asset(AppImages.search, width: 20.w),
        ).paddingOnly(left: 16.w, right: 16.w, top: 20.h, bottom: 30.h),

        /// Tab Bar
        const _TabBarView(),
      ],
    );
  }
}

class _TabBarView extends GetView<AdminNavigationController> {
  const _TabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: controller.tabsSections.length,
        child: Column(
          children: [
            TabBar(
              tabs: controller.tabsSections
                  .map(
                    (e) => Tab(
                      child: Text(e.toString(), style: getMediumStyle(fontSize: 13.sp)),
                    ),
                  )
                  .toList(),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: .1.w,
              isScrollable: true,
              indicatorColor: Colors.black,
              onTap: (value) {},
            ),
            Expanded(
              child: TabBarView(
                children: controller.tabsSections
                    .map(
                      (e) => ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        itemCount: 10,
                        separatorBuilder: (context, index) => Divider(
                          height: .1.h,
                          color: AppColors.greyColor,
                        ).paddingSymmetric(vertical: 10.h),
                        itemBuilder: (context, index) => const _ProductItem(),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.notificationImage,
          width: 83.w,
          height: 63.h,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'بيت خشبي مضيئ',
                style: getBoldStyle(fontSize: 11.sp),
              ),
              Text(
                'هذا النص هو مثال لنص يمكن أن يستبدل توليد هذا النص من مولد النص العربى' * 2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(fontSize: 9.sp),
              ),
              6.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '150ر.س',
                    style: getBoldStyle(fontSize: 11.sp, color: AppColors.primaryColor),
                  ),
                  Text(
                    'عمليات الشراء: 10',
                    style: getMediumStyle(fontSize: 9.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ).paddingOnly(left: 16.w);
  }
}
