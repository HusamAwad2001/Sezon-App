import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/user/user_navigation_controller.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';

import '../../../../../controllers/user/favorite_controller.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../models/product_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../widgets/loading_widget.dart';

class CategoryFragment extends StatelessWidget {
  const CategoryFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserNavigationController>(
      builder: (controller) {
        List data = controller.products
            .where((element) =>
                element.category == controller.tabsSections[controller.sectionIndex]['name']!)
            .toList();

        return Row(
          children: [
            const _CategoriesRightWidget(),

            /// Expanded
            Expanded(
              child: controller.isLoading.value
                  ? const LoadingWidget()
                  : controller.status == false
                      ? const Center(child: Text(AppStrings.somethingWentWrong))
                      : data.isEmpty
                          ? const Center(child: Text(AppStrings.emptyProducts))
                          : GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 19.w,
                                mainAxisSpacing: 19.h,
                              ),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return _ProductItem(data[index]);
                              },
                            ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoriesRightWidget extends GetView<UserNavigationController> {
  const _CategoriesRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.25 + 5.w,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          ...controller.tabsSections.map(
            (e) {
              return GestureDetector(
                onTap: () {
                  controller.sectionIndex = controller.tabsSections.indexOf(e);
                  controller.update();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    3.pw,
                    _CategoryItem(title: e['name']!, image: e['image']!),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      width: 3.w,
                      height: 100.h,
                      color: controller.tabsSections.indexOf(e) == controller.sectionIndex
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String title;
  final String image;

  const _CategoryItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.ph,
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
            style: getMediumStyle(fontSize: 12.sp),
          ),
        ),
        10.ph,
      ],
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
                    height: 80.h,
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
                  style: getMediumStyle(fontSize: 8.sp),
                ),
                5.ph,
                Text(
                  '${productModel.price} ر.س',
                  style: getBoldStyle(fontSize: 8.sp, color: AppColors.primaryColor),
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
              padding: EdgeInsets.all(4.w),
              decoration: ShapeDecoration(
                shape: const OvalBorder(),
                color: Colors.white.withOpacity(0.2),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.favorite,
                size: 10.w,
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
