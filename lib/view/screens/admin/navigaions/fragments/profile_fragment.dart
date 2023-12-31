import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/empty_padding.dart';
import '../../../../../core/storage/global.dart';
import '../../../../../core/storage/storage.dart';
import '../../../../../routes/routes.dart';

import '../../../../widgets/app_button.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(Global.user['userName']),
          ),
          10.ph,
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(Global.user['phone']),
          ),
          40.ph,
          AppButton(
            label: 'تسجيل الخروج',
            onPressed: () {
              Storage.instance.remove('user');
              Get.offAllNamed(Routes.loginScreen);
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
