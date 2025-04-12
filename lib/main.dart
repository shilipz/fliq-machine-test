// main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fliq/core/routes/app_routes.dart';
import 'package:fliq/features/auth/presentation/controllers/auth_controller.dart';

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
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
