import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/storage/storage.dart';
import '../../../../routes/routes.dart';

class AdminNavigationScreen extends StatelessWidget {
  const AdminNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            await Storage.instance.remove('user');
            Get.offAllNamed(Routes.loginScreen);
          },
          child: Text('Logout Admin'),
        ),
      ),
    );
  }
}
