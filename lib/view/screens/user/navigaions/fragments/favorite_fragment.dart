import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../models/product_model.dart';
import '../../../../widgets/loading_widget.dart';

class FavoriteFragment extends StatelessWidget {
  const FavoriteFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('Favorite Fragment')),
    );
  }
}

class _ProductItem extends StatelessWidget {
  final ProductModel productModel;

  const _ProductItem(this.productModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
