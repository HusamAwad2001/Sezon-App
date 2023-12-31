import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/empty_padding.dart';
import '../../../models/product_model.dart';
import '../../widgets/custom_app_bar.dart';

import '../../../core/constants/app_colors.dart';
import '../../widgets/loading_widget.dart';

class AdminProductDetailsScreen extends StatelessWidget {
  const AdminProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = Get.arguments;
    return Scaffold(
      appBar: customAppBar(title: AppStrings.productDetails, isBack: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: productModel.id!,
            child: CachedNetworkImage(
              imageUrl: productModel.imageUrl!,
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error, size: 30.w)),
              fit: BoxFit.fitWidth,
            ),
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
              ),
              10.ph,

              /// Price
              Text(
                '${productModel.price.toString()} ر.س',
                style: getBoldStyle(
                    fontSize: 15.sp, color: AppColors.primaryColor),
              ),
              10.ph,

              /// Description
              Text(
                productModel.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(fontSize: 11.sp),
              ),
              13.ph,

              /// Category
              Text(
                AppStrings.productCategory,
                style: getBoldStyle(fontSize: 10.sp),
              ),
              3.ph,
              Text(
                productModel.category,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(fontSize: 11.sp),
              ),
              13.ph,

              /// Date Added
              Text(
                AppStrings.dateAdded,
                style: getBoldStyle(fontSize: 10.sp),
              ),
              3.ph,
              Text(
                productModel.createdAt!.toString().substring(0, 10),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(fontSize: 11.sp),
              ),
              13.ph,

              /// Purchases
              Text(
                AppStrings.purchases,
                style: getBoldStyle(fontSize: 10.sp),
              ),
              3.ph,
              Text(
                '${productModel.purchases.toString()} مرات',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(fontSize: 11.sp),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.w),
        ],
      ),
    );
  }
}
