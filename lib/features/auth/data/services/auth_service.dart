import 'dart:developer';

import 'package:fliq/core/constants/api_endpoints.dart';
import 'package:fliq/core/network/api_service.dart';
import 'package:fliq/core/services/storage_service.dart';
import 'package:japx/japx.dart';

class AuthService {
  static Future<void> sendOtp(String phone) async {
    try {
      final response = await ApiService.post(
        ApiEndpoints.sendOtp,
        type: 'registration_otp_codes',
        attributes: {'phone': phone},
      );

      //log('Raw Response: ${response.data}');

      if (response.statusCode != 200 || response.data['status'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      //log('sendOtp error: $e');
      rethrow;
    }
  }

  static Future<void> verifyOtp(String phone, String otp) async {
    try {
      final url = ApiEndpoints.verifyOtp;

      final body = {
        'data': {
          'type': 'registration_otp_codes',
          'attributes': {
            'phone': phone,
            'otp': int.parse(otp),
          },
        }
      };

      //log(' OTP Verify URL: $url');
      //log(' Request Body: ${body.toString()}');

      final response = await ApiService.postRawJson(url, body);

      //log(' Raw OTP Verify Response: ${response.data}');

      final decoded = Japx.decode(response.data);
      //log(' Decoded Response: $decoded');

      final attributes = decoded['data']['attributes'];
      //log(' Attributes: $attributes');
      final status = decoded['status'];
      final message = decoded['message'] ?? 'OTP verification failed';

      if (response.statusCode != 200 || (status != null && status != true)) {
        throw Exception(message);
      }

      final token = decoded['data']['auth_status']['access_token'];
      await StorageService.saveToken(token);
      log(' Token saved to local storagem $token');
    } catch (e) {
      //log(' verifyOtp error: $e');
      rethrow;
    }
  }
}
