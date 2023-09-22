import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/constants/empty_padding.dart';

class SalesFragment extends StatelessWidget {
  const SalesFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: 10,
      separatorBuilder: (context, index) => 10.ph,
      itemBuilder: (context, index) {
        return const _SalesItem();
      },
    );
  }
}

class _SalesItem extends StatelessWidget {
  const _SalesItem({super.key});

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
          Image.asset(
            AppImages.notificationImage,
            width: 83.w,
            height: 63.h,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'بيت خشبي مضيئ',
                  style: getBoldStyle(fontSize: 13.sp),
                ),
                Text(
                  'هذا النص هو مثال لنص يمكن أن يستبدل توليد هذا النص من مولد النص العربى' *
                      2,
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
