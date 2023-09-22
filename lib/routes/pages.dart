import 'package:get/get.dart';
import '../bindings/admin/add_product_bunding.dart';
import '../bindings/admin/admin_navigation_binding.dart';
import '../bindings/auth/login_binding.dart';
import '../bindings/auth/otp_binding.dart';
import '../bindings/auth/register_binding.dart';
import '../bindings/user/buy_now_bunding.dart';
import '../view/screens/admin/add_product_screen.dart';
import '../view/screens/admin/admin_product_details_screen.dart';
import '../view/screens/admin/navigaions/admin_navigation_screen.dart';
import '../view/screens/auth/otp_screen.dart';
import '../view/screens/user/buy_now_screen.dart';

import '../routes/routes.dart';
import '../view/screens/auth/login_screen.dart';
import '../view/screens/auth/register_screen.dart';
import '../view/screens/splash_screen.dart';
import '../view/screens/user/navigaions/user_navigation_screen.dart';
import '../view/screens/user/user_product_details_screen.dart';

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
      GetPage(
        name: Routes.userProductDetailsScreen,
        page: () => const UserProductDetailsScreen(),
      ),
      GetPage(
        name: Routes.buyNowScreen,
        page: () => const BuyNowScreen(),
        binding: BuyNowBinding(),
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
      GetPage(
        name: Routes.adminProductDetailsScreen,
        page: () => const AdminProductDetailsScreen(),
      ),
    ];
  }
}
