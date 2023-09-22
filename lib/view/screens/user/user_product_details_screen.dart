import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/core/constants/app_styles.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/models/product_model.dart';
import 'package:sezon_app/routes/routes.dart';
import 'package:sezon_app/view/widgets/app_button.dart';
import 'package:sezon_app/view/widgets/custom_app_bar.dart';
import 'package:sezon_app/view/widgets/custom_title.dart';

import '../../../controllers/user/favorite_controller.dart';
import '../../../controllers/user/user_navigation_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/snack.dart';

class UserProductDetailsScreen extends StatelessWidget {
  const UserProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = Get.arguments['productModel'];
    List<ProductModel> products = Get.arguments['products']
        .where((element) => element.category != productModel.category)
        .toList();

    return Scaffold(
      appBar: customAppBar(title: AppStrings.productDetails, isBack: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: productModel.imageUrl!,
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error, size: 30.w)),
              fit: BoxFit.cover,
              width: Get.width,
              height: 235.h,
            ),
            20.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Name
                Text(
                  productModel.name,
                  style: getBoldStyle(fontSize: 15.sp),
                ).paddingSymmetric(horizontal: 16.w),
                10.ph,

                /// Price
                Text(
                  '${productModel.price.toString()} ر.س',
                  style: getBoldStyle(fontSize: 15.sp, color: AppColors.primaryColor),
                ).paddingSymmetric(horizontal: 16.w),
                10.ph,

                /// Description
                Text(
                  productModel.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(fontSize: 11.sp),
                ).paddingSymmetric(horizontal: 16.w),
                30.ph,

                /// Related Products
                const CustomTitle(title: AppStrings.relatedProducts)
                    .paddingSymmetric(horizontal: 16.w),
                19.ph,

                /// Related Products List
                SizedBox(
                  height: 160.h,
                  child: products.isEmpty
                      ? Card(
                          color: Colors.grey.withOpacity(.2),
                          elevation: 0,
                          child: const Center(child: Text(AppStrings.relatedEmptyProducts)),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          separatorBuilder: (context, index) => 10.pw,
                          itemBuilder: (context, index) {
                            return _ProductItem(products[index]);
                          },
                        ),
                ),

                /// Add to Favorite and Buy Now
                16.ph,
                _BottomButtonsWidget(productModel: productModel).paddingSymmetric(horizontal: 16.w),
              ],
            )
          ],
        ),
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
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
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
              border: Border.all(
                color: Colors.black.withOpacity(.13),
                width: .5,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.asset(AppImages.category4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: CachedNetworkImage(
                    height: 83.h,
                    width: 99.w,
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
              child: GetBuilder<FavoriteController>(
                builder: (_) {
                  return Icon(
                    Icons.favorite,
                    size: 10.w,
                    color: favoriteController.favoritesList
                            .any((element) => element['id'] == productModel.id)
                        ? Colors.red
                        : const Color(0xFFDEDFDF),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomButtonsWidget extends StatelessWidget {
  final ProductModel productModel;

  const _BottomButtonsWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(3.r),
                bottomRight: Radius.circular(3.r),
              ),
              child: AppButton(
                label: AppStrings.addToFavorite,
                backgroundColor: Colors.white,
                textColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                borderRadius: 0,
                onPressed: () {
                  FavoriteController favoriteController = Get.find<FavoriteController>();
                  var isExist = favoriteController.favoritesList
                      .any((element) => element['id'] == productModel.id);

                  if (isExist) {
                    Snack().show(type: true, message: AppStrings.productIsExist);
                  } else {
                    favoriteController.addProduct(productModel);
                    Snack().show(type: true, message: AppStrings.added);
                  }
                  Get.find<UserNavigationController>().update();
                },
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3.r),
                bottomLeft: Radius.circular(3.r),
              ),
              child: AppButton(
                label: AppStrings.buyNow,
                borderRadius: 0,
                onPressed: () => Get.toNamed(Routes.buyNowScreen, arguments: productModel),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10.w),
    );
  }
}
