import 'package:get/get.dart';
import 'package:sezon_app/bindings/admin/add_product_bunding.dart';
import 'package:sezon_app/bindings/admin/admin_navigation_binding.dart';
import 'package:sezon_app/bindings/auth/login_binding.dart';
import 'package:sezon_app/bindings/auth/otp_binding.dart';
import 'package:sezon_app/bindings/auth/register_binding.dart';
import 'package:sezon_app/view/screens/admin/add_product_screen.dart';
import 'package:sezon_app/view/screens/admin/navigaions/admin_navigation_screen.dart';
import 'package:sezon_app/view/screens/auth/otp_screen.dart';

import '../routes/routes.dart';
import '../view/screens/auth/login_screen.dart';
import '../view/screens/auth/register_screen.dart';
import '../view/screens/splash_screen.dart';
import '../view/screens/user/navigaions/user_navigation_screen.dart';

class Pages {
  static List<GetPage> getPages() {
    return [
      /// Splash Screen
      GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreen(),
      ),

      /// Auth Screens
      GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: Routes.registerScreen,
        page: () => const RegisterScreen(),
        binding: RegisterBinding(),
      ),
      GetPage(
        name: Routes.otpScreen,
        page: () => const OtpScreen(),
        binding: OtpBinding(),
      ),

      /// User Screens
      GetPage(
        name: Routes.userNavigationScreen,
        page: () => const UserNavigationScreen(),
      ),

      /// Admin Screens
      GetPage(
        name: Routes.adminNavigationScreen,
        page: () => const AdminNavigationScreen(),
        binding: AdminNavigationBinding(),
      ),
      GetPage(
        name: Routes.addProductScreen,
        page: () => const AddProductScreen(),
        binding: AddProductBinding(),
      ),
    ];
  }
}
