import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon_app/controllers/admin/add_product_controller.dart';
import 'package:sezon_app/core/constants/app_colors.dart';
import 'package:sezon_app/core/constants/app_images.dart';
import 'package:sezon_app/core/constants/app_strings.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/core/constants/shared_functions.dart';
import 'package:sezon_app/view/widgets/app_button.dart';
import 'package:sezon_app/view/widgets/custom_app_bar.dart';
import 'package:sezon_app/view/widgets/custom_radio.dart';
import 'package:sezon_app/view/widgets/loading_widget.dart';
import 'package:sezon_app/view/widgets/title_bottom_sheet.dart';

import '../../../core/constants/app_styles.dart';
import '../../widgets/app_text_field.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: AppStrings.addNewProduct,
        isBack: true,
      ),
      body: const _BodyView(),
    );
  }
}

class _BodyView extends GetView<AddProductController> {
  const _BodyView({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          /// Title
          20.ph,
          const CustomTitle(title: AppStrings.addNewProduct),

          /// Form
          30.ph,
          const _FormWidget(),

          /// Button
          80.ph,
          Obx(
            () {
              return controller.isLoading.value
                  ? const LoadingWidget()
                  : AppButton(
                      label: AppStrings.add,
                      onPressed: () {
                        scrollController.animateTo(0,
                            duration: 400.milliseconds, curve: Curves.easeIn);
                        controller.addProduct();
                      },
                    );
            },
          ),
          100.ph,
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}

class _FormWidget extends GetView<AddProductController> {
  const _FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          controller: controller.nameProductController,
          hintText: AppStrings.hintProductTitle,
          label: AppStrings.productTitle,
          textColor: Colors.black,
        ),
        20.ph,
        AppTextField(
          controller: controller.descriptionProductController,
          hintText: AppStrings.hintProductDescription,
          label: AppStrings.productDescription,
          textColor: Colors.black,
          minLines: 3,
          maxLines: 3,
        ),
        20.ph,
        AppTextField(
          controller: controller.priceProductController,
          hintText: AppStrings.hintPrice,
          textInputType: TextInputType.number,
          label: AppStrings.price,
          textColor: Colors.black,
        ),
        20.ph,
        GestureDetector(
          onTap: () => controller.pickImage(),
          child: AppTextField(
            isEnabled: false,
            controller: controller.imageProductController,
            hintText: AppStrings.hintAddProductImg,
            label: AppStrings.addProductImg,
            textColor: Colors.black,
            suffix: SvgPicture.asset(AppImages.upload),
          ),
        ),
        20.ph,
        GestureDetector(
          onTap: () => openBottomSheet(AppStrings.addNewProduct, const _BodyBottomSheet()),
          child: AppTextField(
            controller: controller.selectCategoryController,
            isEnabled: false,
            hintText: AppStrings.hintSelectProductCategory,
            label: AppStrings.selectProductCategory,
            textColor: Colors.black,
            suffix: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30.w,
              color: AppColors.greyColor3,
            ),
          ),
        ),
      ],
    );
  }
}

class _BodyBottomSheet extends GetView<AddProductController> {
  const _BodyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<AddProductController>(
          init: AddProductController(),
          builder: (_) {
            return Column(
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
                              Text(
                                option.label,
                                style: getRegularStyle(fontSize: 14.sp),
                              ),
                              CustomRadio(
                                value: option.value,
                                groupValue: controller.selectedValue,
                              ),
                            ],
                          ).paddingSymmetric(vertical: 22.h),
                          option.value == controller.options.length
                              ? 0.ph
                              : Divider(height: .1.h, color: AppColors.greyColor),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
        AppButton(
          label: AppStrings.next,
          onPressed: () {
            controller.selectCategoryController.text =
                controller.options[controller.selectedValue - 1].label;
            Get.back();
          },
        ),
      ],
    );
  }
}
