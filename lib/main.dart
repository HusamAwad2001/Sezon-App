import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/constants/app_themes.dart';
import 'firebase_options.dart';

import '../routes/pages.dart';
import '../routes/routes.dart';
import 'core/storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  Storage.getData();
  // Storage.instance.remove('user');
  // print(Global.user['id']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          title: 'Sezon App',
          theme: AppThemes.light,
          initialRoute: Routes.splashScreen,
          getPages: Pages.getPages(),
        );
      },
    );
  }
}
