import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';

import '../../../../../controllers/user/requests_controller.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../models/shopping_model.dart';
import '../../../../widgets/loading_widget.dart';

class RequestsFragment extends StatelessWidget {
  const RequestsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RequestsController());
    return GetBuilder<RequestsController>(
      init: RequestsController(),
      builder: (controller) {
        return DefaultTabController(
          length: controller.tabsSections.length,
          child: Column(
            children: [
              TabBar(
                tabs: controller.tabsSections
                    .map((e) => Tab(
                          child: Text(e.toString(), style: getMediumStyle(fontSize: 13.sp)),
                        ))
                    .toList(),
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: false,
                indicatorColor: AppColors.primaryColor,
                onTap: (value) {
                  controller.selectedIndex = value;
                  controller.getShopping();
                  controller.update();
                },
              ),
              Expanded(
                child: TabBarView(
                  children: controller.tabsSections.map((e) => const _ListViewWidget()).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ListViewWidget extends GetView<RequestsController> {
  const _ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('RequestsFragment'));
    return Obx(
      () {
        return controller.isLoading.value
            ? const LoadingWidget()
            : controller.status == false
                ? const Center(child: Text(AppStrings.somethingWentWrong))
                : controller.myRequests.isEmpty
                    ? Center(
                        child: Text(
                          controller.selectedIndex == 0
                              ? AppStrings.emptyShoppingPending
                              : AppStrings.emptyShoppingAccepted,
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        itemCount: controller.myRequests.length,
                        separatorBuilder: (context, index) => Divider(
                          height: .1.h,
                          color: AppColors.greyColor,
                        ).paddingSymmetric(vertical: 10.h),
                        itemBuilder: (context, index) {
                          return _ShoppingItem(controller.myRequests[index]);
                        },
                      );
      },
    );
  }
}

class _ShoppingItem extends StatelessWidget {
  final ShoppingModel shoppingModel;

  const _ShoppingItem(
    this.shoppingModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: CachedNetworkImage(
              imageUrl: shoppingModel.product.imageUrl!,
              width: 83.w,
              height: 63.h,
              fit: BoxFit.cover,
            ),
          ),
          15.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shoppingModel.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getBoldStyle(fontSize: 13.sp),
                ),
                Text(
                  shoppingModel.product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ],
      ).paddingOnly(left: 16.w),
    );
  }
}
