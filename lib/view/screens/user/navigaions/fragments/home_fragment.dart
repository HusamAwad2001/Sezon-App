import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/user/favorite_controller.dart';
import '../../../../../controllers/user/user_navigation_controller.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/constants/empty_padding.dart';
import '../../../../../models/product_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/custom_title.dart';
import '../../../../widgets/loading_widget.dart';

class HomeFragment extends GetView<UserNavigationController> {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Search Bar
          const _SearchBar(),

          /// Categories
          const CustomTitle(title: AppStrings.categories).paddingSymmetric(horizontal: 16.w),
          10.ph,
          Row(
            children: [
              const _CategoryItem(
                title: AppStrings.porcelain,
                image: AppImages.category1,
              ),
              18.pw,
              const _CategoryItem(title: AppStrings.wreaths, image: AppImages.category2),
              18.pw,
              const _CategoryItem(title: AppStrings.embroideries, image: AppImages.category3),
              18.pw,
              const _CategoryItem(title: AppStrings.wooden, image: AppImages.category4),
              18.pw,
              const _CategoryItem(title: AppStrings.accessories, image: AppImages.category5),
            ],
          ).paddingSymmetric(horizontal: 16.w),

          /// Products
          20.ph,
          const CustomTitle(title: AppStrings.products).paddingSymmetric(horizontal: 16.w),
          const _StatusGridView(),
        ],
      ),
    );
  }
}

class _SearchBar extends GetView<UserNavigationController> {
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
    ).paddingSymmetric(horizontal: 15.w, vertical: 15.h);
  }
}

class _StatusGridView extends GetView<UserNavigationController> {
  const _StatusGridView({super.key});

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
                    : GetBuilder<UserNavigationController>(
                        builder: (_) {
                          return (controller.isSearching == true &&
                                  controller.searchedProducts.isEmpty)
                              ? const Align(
                                  alignment: Alignment.center,
                                  child: Text(AppStrings.emptyProducts),
                                )
                              : const _GridView();
                        },
                      );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String title;
  final String image;

  const _CategoryItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
          10.ph,
          FittedBox(
            child: Text(
              title,
              style: getRegularStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserNavigationController>(builder: (controller) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 19.w,
          mainAxisSpacing: 19.h,
        ),
        itemCount: controller.isSearching
            ? controller.searchedProducts.length
            : controller.products.length,
        itemBuilder: (context, index) {
          // return const _ProductItem();
          return controller.isSearching
              ? _ProductItem(controller.searchedProducts[index])
              : _ProductItem(controller.products[index]);
        },
      );
    });
  }
}

class _ProductItem extends StatelessWidget {
  final ProductModel productModel;

  const _ProductItem(this.productModel, {super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController favoriteController = Get.put(FavoriteController());
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.userProductDetailsScreen,
              arguments: {
                'productModel': productModel,
                'products': Get.find<UserNavigationController>().products,
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.20),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.asset(AppImages.category4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: CachedNetworkImage(
                    height: 135.h,
                    imageUrl: productModel.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const LoadingWidget(),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error,
                        size: 30.w,
                      ),
                    ),
                  ),
                ),
                10.ph,
                Text(
                  productModel.name,
                  style: getMediumStyle(fontSize: 9.sp),
                ),
                5.ph,
                Text(
                  '${productModel.price} ر.س',
                  style: getBoldStyle(fontSize: 10.sp, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16.h,
          left: 16.w,
          child: GestureDetector(
            onTap: () {
              favoriteController.addOrDeleteProduct(productModel);
              Get.find<UserNavigationController>().update();
            },
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: ShapeDecoration(
                shape: const OvalBorder(),
                color: Colors.white.withOpacity(0.2),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.favorite,
                color: favoriteController.favoritesList
                        .any((element) => element['id'] == productModel.id)
                    ? Colors.red
                    : const Color(0xFFDEDFDF),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
