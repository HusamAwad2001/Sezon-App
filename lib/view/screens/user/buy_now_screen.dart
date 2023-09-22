import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/user/buy_now_controller.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/empty_padding.dart';
import '../../../core/constants/shared_functions.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_widget.dart';

import '../../../core/constants/app_colors.dart';
import '../../widgets/custom_radio.dart';

class BuyNowScreen extends StatelessWidget {
  const BuyNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    addAddress() {
      openBottomSheet(AppStrings.addNewAddress, const _AddAddressSheet());
    }

    paymentMethod() {
      openBottomSheet(AppStrings.paymentMethod, const _PaymentMethodSheet());
    }

    addProductSpecifications() {
      openBottomSheet(AppStrings.addProductSpecifications,
          const _AddProductSpecificationsSheet());
    }

    return GetBuilder<BuyNowController>(
      init: BuyNowController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar(
              title: AppStrings.completeYourPurchase, isBack: true),
          body: Column(
            children: [
              /// Address
              controller.address != null
                  ? _CardDataWidget(
                      title: controller.address!,
                      image: AppImages.location,
                      onTap: () => addAddress(),
                    )
                  : _ItemWidget(
                      title: AppStrings.addAddress,
                      onTap: () => addAddress(),
                    ),

              /// Payment Method
              controller.paymentMethod != null
                  ? _CardDataWidget(
                      title: controller.paymentMethod!,
                      image: AppImages.pay,
                      onTap: () => paymentMethod(),
                    )
                  : _ItemWidget(
                      title: AppStrings.paymentMethod,
                      onTap: () => paymentMethod(),
                    ),

              /// Product Description
              controller.productDescription != null
                  ? _CardDataWidget(
                      title: controller.productDescription!,
                      image: AppImages.payDescription,
                      onTap: () => addProductSpecifications(),
                    )
                  : _ItemWidget(
                      title: AppStrings.addProductSpecifications,
                      onTap: () => addProductSpecifications(),
                    ),

              /// Summery Widget
              ...[controller.isReady ? const _SummeryWidget() : 0.pw],

              const Spacer(),

              /// Button
              Obx(() {
                return controller.isLoaded.value
                    ? const LoadingWidget()
                    : AppButton(
                        label: AppStrings.confirmation,
                        onPressed: () => controller.confirmation(),
                      );
              }),
            ],
          ).paddingSymmetric(horizontal: 26.w, vertical: 30.h),
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final String title;
  final Function() onTap;

  const _ItemWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Image.asset(AppImages.location, height: 20.h),
            10.pw,
            Text(
              title,
              style: getMediumStyle(fontSize: 14.sp),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              // color: Colors.black,
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w, vertical: 18.h),
      ),
    ).paddingOnly(bottom: 10.h);
  }
}

/// Address Bottom Sheet Widget
class _AddAddressSheet extends StatelessWidget {
  const _AddAddressSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyNowController>(
      init: BuyNowController(),
      builder: (controller) {
        return Expanded(
          flex: 1,
          child: ListView(
            children: [
              22.ph,
              AppTextField(
                controller: controller.countryController,
                hintText: AppStrings.hintCountry,
                label: AppStrings.country,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.regionController,
                hintText: AppStrings.hintRegion,
                label: AppStrings.region,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.cityController,
                hintText: AppStrings.hintCity,
                label: AppStrings.city,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.streetController,
                hintText: AppStrings.hintStreet,
                label: AppStrings.street,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.zipCodeController,
                hintText: AppStrings.hintZipCode,
                label: AppStrings.zipCode,
                textInputType: TextInputType.number,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.phoneController,
                hintText: AppStrings.hintPhoneNumber,
                label: AppStrings.phoneNumber,
                textInputType: TextInputType.phone,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              22.ph,
              AppButton(
                label: AppStrings.save,
                onPressed: () => controller.addAddress(),
              ),
              10.ph,
              AppButton(
                label: AppStrings.close,
                backgroundColor: Colors.white,
                borderColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Payment Method Bottom Sheet Widget
class _PaymentMethodSheet extends StatelessWidget {
  const _PaymentMethodSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyNowController>(
      init: BuyNowController(),
      builder: (controller) {
        return Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: controller.options.map(
                (option) {
                  return GestureDetector(
                    onTap: () => controller.setSelectedValue(option.value),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(option.image!,
                                  height: 20.h, fit: BoxFit.cover),
                              8.pw,
                              Text(
                                option.label,
                                style: getRegularStyle(fontSize: 14.sp),
                              ),
                              const Spacer(),
                              CustomRadio(
                                value: option.value,
                                groupValue: controller.selectedValue,
                              ),
                            ],
                          ).paddingSymmetric(vertical: 22.h),
                          option.value == controller.options.length
                              ? 0.ph
                              : Divider(
                                  height: .1.h, color: AppColors.greyColor),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            AppButton(
              label: AppStrings.next,
              onPressed: () {
                controller.paymentMethod =
                    controller.options[controller.selectedValue - 1].label;
                controller.update();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}

/// Product Specifications Bottom Sheet Widget
class _AddProductSpecificationsSheet extends StatelessWidget {
  const _AddProductSpecificationsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyNowController>(
      init: BuyNowController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              22.ph,
              AppTextField(
                controller: controller.productTitleController,
                hintText: AppStrings.hintProductTitle,
                label: AppStrings.productTitle,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.productQuantityController,
                hintText: AppStrings.quantityCount,
                label: AppStrings.quantity,
                textInputType: TextInputType.number,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.productColorController,
                hintText: AppStrings.hintProductColor,
                label: AppStrings.productColor,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              15.ph,
              AppTextField(
                controller: controller.productSizeController,
                hintText: AppStrings.hintSize,
                label: AppStrings.size,
                labelStyle: getMediumStyle(fontSize: 14.sp),
              ),
              22.ph,
              AppButton(
                label: AppStrings.save,
                onPressed: () {
                  controller.addDescription();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Card Item Widget
class _CardDataWidget extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;

  const _CardDataWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, height: 20.h),
          10.pw,
          Expanded(
            child: Text(
              title,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: getMediumStyle(fontSize: 14.sp),
            ),
          ),
          15.pw,
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.edit_note,
                color: AppColors.primaryColor, size: 30.w),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w, vertical: 18.h),
    ).paddingOnly(bottom: 10.h);
  }
}

/// Summery Widget
class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الملخص', style: getBoldStyle(fontSize: 13.sp)),
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مدة الشحن',
                style: getRegularStyle(fontSize: 13.sp),
              ),
              Text(
                '5 أيام',
                style: getRegularStyle(fontSize: 13.sp),
              ),
            ],
          ),
          Divider(color: AppColors.greyColor.withOpacity(.4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي تكلفة المنتج',
                style: getRegularStyle(fontSize: 13.sp),
              ),
              Text(
                '130ر.س',
                style: getRegularStyle(fontSize: 13.sp),
              ),
            ],
          ),
          Divider(color: AppColors.greyColor.withOpacity(.4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي تكلفة الشحن',
                style: getRegularStyle(fontSize: 13.sp),
              ),
              Text(
                '90ر.س',
                style: getRegularStyle(fontSize: 13.sp),
              ),
            ],
          ),
          Divider(color: AppColors.greyColor.withOpacity(.4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع الكلي',
                style: getBoldStyle(fontSize: 13.sp),
              ),
              Text(
                '210ر.س',
                style: getBoldStyle(fontSize: 13.sp),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w, vertical: 18.h),
    );
  }
}
