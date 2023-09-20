import 'package:get/get.dart';
import 'package:sezon_app/bindings/auth/login_binding.dart';
import 'package:sezon_app/bindings/auth/otp_binding.dart';
import 'package:sezon_app/bindings/auth/register_binding.dart';
import 'package:sezon_app/view/screens/auth/otp_screen.dart';
import 'package:sezon_app/view/screens/navigaions/navigation_screen.dart';

import '../routes/routes.dart';
import '../view/screens/auth/login_screen.dart';
import '../view/screens/auth/register_screen.dart';
import '../view/screens/splash_screen.dart';

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

      GetPage(
        name: Routes.navigationScreen,
        page: () => const NavigationScreen(),
      ),
    ];
  }
}
