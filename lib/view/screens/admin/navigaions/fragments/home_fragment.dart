import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/admin/admin_navigation_controller.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/constants/empty_padding.dart';
import '../../../../../models/product_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/loading_widget.dart';

class HomeFragment extends GetView<AdminNavigationController> {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SearchBar(),
        _TabBar(),
      ],
    );
  }
}

class _SearchBar extends GetView<AdminNavigationController> {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller.searchController,
      hintText: AppStrings.hintSearch,
      hintColor: AppColors.greyColor2,
      borderRadius: 10.r,
      backgroundColor: Colors.black.withOpacity(0.04),
      enableBorderColor: Colors.transparent,
      focusBorderColor: Colors.transparent,
      prefix: SvgPicture.asset(AppImages.search, width: 20.w),
      onChanged: (query) {
        if (query.isNotEmpty || query != '') {
          controller.isSearching = true;
          controller.search(query);
        } else {
          controller.isSearching = false;
        }
        controller.update();
      },
    ).paddingOnly(left: 16.w, right: 16.w, top: 20.h, bottom: 30.h);
  }
}

class _TabBar extends GetView<AdminNavigationController> {
  const _TabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: controller.tabsSections.length,
        child: Column(
          children: [
            TabBar(
              tabs: controller.tabsSections.map(
                (e) {
                  return Tab(
                    child: Text(e.toString(), style: getMediumStyle(fontSize: 13.sp)),
                  );
                },
              ).toList(),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: .1.w,
              isScrollable: true,
              indicatorColor: Colors.black,
              onTap: (value) {
                controller.isSearching = false;
                controller.searchController.clear();
                controller.searchedProducts.clear();
                controller.sectionIndex = value;
                controller.getAllProducts();
              },
            ),
            Expanded(
              child: TabBarView(
                children: controller.tabsSections.map((e) => const _CheckTabBar()).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckTabBar extends GetView<AdminNavigationController> {
  const _CheckTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.isLoading.value
            ? const LoadingWidget()
            : controller.status == false
                ? const Center(child: Text(AppStrings.somethingWentWrong))
                : controller.products.isEmpty
                    ? const Center(child: Text(AppStrings.emptyProducts))
                    : GetBuilder<AdminNavigationController>(
                        builder: (_) {
                          return (controller.isSearching && controller.searchedProducts.isEmpty)
                              ? Center(
                                  child: const Text(AppStrings.emptyProducts)
                                      .paddingOnly(bottom: 130.h))
                              : const _ListViewWidget();
                        },
                      );
      },
    );
  }
}

class _ListViewWidget extends StatelessWidget {
  const _ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminNavigationController>(
      builder: (controller) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          itemCount: controller.isSearching
              ? controller.searchedProducts.length
              : controller.products.length,
          separatorBuilder: (context, index) => Divider(
            height: .1.h,
            color: AppColors.greyColor,
          ).paddingSymmetric(vertical: 10.h),
          itemBuilder: (context, index) {
            return controller.isSearching
                ? _ProductItem(controller.searchedProducts[index])
                : _ProductItem(controller.products[index]);
          },
        );
      },
    );
  }
}

class _ProductItem extends StatelessWidget {
  final ProductModel productModel;

  const _ProductItem(this.productModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.adminProductDetailsScreen, arguments: productModel),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Hero(
              tag: productModel.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: productModel.imageUrl!,
                  width: 83.w,
                  height: 63.h,
                  placeholder: (context, url) => const LoadingWidget(),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.error,
                      size: 30.w,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            15.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    style: getBoldStyle(fontSize: 11.sp),
                  ),
                  Text(
                    productModel.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(fontSize: 9.sp),
                  ),
                  6.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${productModel.price.toString()} ر.س',
                        style: getBoldStyle(fontSize: 10.sp, color: AppColors.primaryColor),
                      ),
                      Text(
                        '${AppStrings.purchases}: ${productModel.purchases.toString()}',
                        style: getMediumStyle(fontSize: 10.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).paddingOnly(left: 16.w),
      ),
    );
  }
}
