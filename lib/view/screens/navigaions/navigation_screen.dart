import 'package:flutter/material.dart';
import 'package:sezon_app/core/constants/md5_encrypt.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            print(generateMd5('123456'));
            // await Storage.instance.remove('user');
            // Get.offAllNamed(Routes.loginScreen);
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
