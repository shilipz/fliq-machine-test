import 'package:fliq/features/auth/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:japx/japx.dart';

class AuthController extends GetxController {
  final phoneNumber = ''.obs;
  final otp = ''.obs;
  final isLoading = false.obs;



  Future<void> sendOtp() async {
    try {
      isLoading.value = true;

      final response = await AuthService.sendOtp(phoneNumber.value);

      Get.toNamed('/otp', arguments: {'phone': phoneNumber.value});
    } catch (e) {
      print(e.toString());

      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading.value = true;

      final response =
          await AuthService.verifyOtp(phoneNumber.value, otp.value);

      Get.offAllNamed('/messages');
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
