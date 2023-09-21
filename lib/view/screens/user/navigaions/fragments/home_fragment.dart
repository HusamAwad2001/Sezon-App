import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/user/favorite_controller.dart';
import 'package:sezon_app/controllers/user/user_navigation_controller.dart';
import 'package:sezon_app/core/constants/app_styles.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/view/widgets/title_bottom_sheet.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../models/product_model.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/loading_widget.dart';

class HomeFragment extends GetView<UserNavigationController> {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Search Bar
        AppTextField(
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
        ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),

        /// Categories
        const CustomTitle(title: AppStrings.categories).paddingSymmetric(horizontal: 16.w),
        10.ph,
        Row(
          children: [
            const _CategoryItem(title: AppStrings.category1, image: AppImages.category1),
            18.pw,
            const _CategoryItem(title: AppStrings.category2, image: AppImages.category2),
            18.pw,
            const _CategoryItem(title: AppStrings.category3, image: AppImages.category3),
            18.pw,
            const _CategoryItem(title: AppStrings.category4, image: AppImages.category4),
            18.pw,
            const _CategoryItem(title: AppStrings.category5, image: AppImages.category5),
          ],
        ).paddingSymmetric(horizontal: 16.w),

        /// Products
        20.ph,
        const CustomTitle(title: AppStrings.products).paddingSymmetric(horizontal: 16.w),
        const _GridView(),
      ],
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

class _GridView extends GetView<UserNavigationController> {
  const _GridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
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
                                : GridView.builder(
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
                          },
                        );
        },
      ),
    );
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
        Container(
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
