import 'package:fliq/features/auth/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final phoneNumber = ''.obs;
  final otp = ''.obs;
  final isLoading = false.obs;
  final RxString fullPhoneNumber = ''.obs;

  Future<void> sendOtp() async {
    try {
      isLoading.value = true;
      debugPrint("Sending OTP to: ${phoneNumber.value}");

      final response = await AuthService.sendOtp(phoneNumber.value);
//
      Get.toNamed('/otp', arguments: {'phone': phoneNumber.value});
    } catch (e) {
      debugPrint("Send OTP error: $e");
      Get.snackbar('Error', 'Failed to send OTP. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading.value = true;
      debugPrint("Verifying OTP for: ${phoneNumber.value}");

      final response =
          await AuthService.verifyOtp(phoneNumber.value, otp.value);
      // debugPrint("OTP verification successful: $response");

      Get.offAllNamed('/messages');
    } catch (e) {
      debugPrint("Verify OTP error: $e");
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
