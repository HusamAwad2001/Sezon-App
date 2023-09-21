import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/user/favorite_controller.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';

import '../../../../../controllers/user/user_navigation_controller.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../models/product_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../widgets/loading_widget.dart';

class FavoriteFragment extends StatelessWidget {
  const FavoriteFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      init: FavoriteController(),
      builder: (controller) {
        return controller.favoritesList.isEmpty
            ? const Center(child: Text(AppStrings.emptyFavorites))
            : ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: controller.favoritesList.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1.3,
                  color: AppColors.greyColor.withOpacity(.4),
                ).paddingSymmetric(vertical: 7.h),
                itemBuilder: (context, index) {
                  final item = ProductModel.fromJson(controller.favoritesList[index]);
                  return _ProductItem(productModel: item, index: index);
                },
              );
      },
    );
  }
}

class _ProductItem extends StatelessWidget {
  final int index;
  final ProductModel productModel;

  const _ProductItem({super.key, required this.productModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        color: Colors.transparent,
        child: Row(
          children: [
            Hero(
              tag: productModel.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: productModel.imageUrl!,
                  width: 80.w,
                  height: 80.h,
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
                    style: getBoldStyle(fontSize: 12.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          productModel.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(fontSize: 10.sp),
                        ),
                      ),
                      10.pw,
                      GestureDetector(
                        onTap: () {
                          Get.find<FavoriteController>().deleteProduct(index);
                        },
                        child: const Icon(Icons.delete, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  6.ph,
                  Text(
                    '${productModel.price.toString()} ر.س',
                    style: getBoldStyle(fontSize: 12.sp, color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
