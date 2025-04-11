import 'dart:developer';

import 'package:fliq/core/constants/api_endpoints.dart';
import 'package:fliq/core/network/api_service.dart';
import 'package:japx/japx.dart';

class AuthService {
  static Future<void> sendOtp(String phone) async {
    try {
      final response = await ApiService.post(
        ApiEndpoints.sendOtp,
        type: 'registration_otp_codes',
        attributes: {'phone': phone},
      );

      log('Raw Response: ${response.data}');

      if (response.statusCode != 200 || response.data['status'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      log('sendOtp error: $e');
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
            'otp': otp,
            'device_meta': {
              'type': 'web',
              'name': 'HP Pavilion 14-EP0068TU',
              'os': 'Linux x86_64',
              'browser': 'Mozilla Firefox Snap for Ubuntu (64-bit)',
              'browser_version': '112.0.2',
              'user_agent':
                  'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/112.0',
              'screen_resolution': '1600x900',
              'language': 'en-GB',
            },
          },
        }
      };

      log(' OTP Verify URL: $url');
      log('Request Body: ${body.toString()}');

      final response = await ApiService.postRawJson(
          url, body); 

      log('OTP Verify Response: ${response.data}');

      if (response.statusCode != 200 || response.data['status'] != true) {
        throw Exception(response.data['message'] ?? 'OTP verification failed');
      }
    } catch (e) {
      log('verifyOtp error: $e');
      rethrow;
    }
  }

  static Future<dynamic> checkUser(String phone) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.checkUser,
        queryParams: {'phone_number': phone},
      );

      final parsed = Japx.decode(response.data);

      if (response.statusCode != 200 && parsed['errors'] != null) {
        throw Exception(
            parsed['errors']?[0]['detail'] ?? 'Failed to check user');
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
