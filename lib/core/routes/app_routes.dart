
import 'package:fliq/features/auth/presentation/pages/otp_page.dart';
import 'package:fliq/features/auth/presentation/pages/phone_number_page.dart';
import 'package:fliq/features/auth/presentation/pages/splash_screen.dart';
import 'package:fliq/features/chat/presentation/pages/chat_list.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/splash';
  static const phone = '/phone';
  static const otp = '/otp';
  static const messages = '/messages';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: phone,
      page: () => const PhoneNumberScreen(),
    ),
    GetPage(
      name: otp,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return OTPVerificationScreen(phone: args['phone']);
      },
    ),
    GetPage(
      name: messages,
      page: () => ChatListScreen(),
    ),
  ];
}
