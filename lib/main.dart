import 'package:fliq/features/auth/presentation/controllers/auth_controller.dart';
import 'package:fliq/features/auth/presentation/pages/phone_number_page.dart';
import 'package:fliq/features/auth/presentation/pages/splash_screen.dart';
import 'package:fliq/features/chat/presentation/pages/messages_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fliq/features/auth/presentation/pages/otp_page.dart';

void main() {
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fliq',
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/phone',
          page: () => const PhoneNumberScreen(),
        ),
        GetPage(
          name: '/otp',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return OTPVerificationScreen(phone: args['phone']);
          },
        ),
        GetPage(
          name: '/messages',
          page: () =>
              MessagesScreen(), 
        ),
      ],
    );
  }
}
