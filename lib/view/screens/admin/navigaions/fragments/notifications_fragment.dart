import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_styles.dart';

class NotificationsFragment extends StatelessWidget {
  const NotificationsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 10,
      separatorBuilder: (context, index) =>
          const Divider(height: 2, color: AppColors.greyColor),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'تم قبول طلبك باضافة منتج بيت خشبي مضيئ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(fontSize: 12.sp),
          ),
          subtitle: Text(
            'منذ 5 ساعات',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(fontSize: 10.sp),
          ),
          trailing: Image.asset(
            AppImages.notificationImage,
            width: 55.w,
            height: 55.h,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
