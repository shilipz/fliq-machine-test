// lib/core/constants/api_endpoints.dart

class ApiEndpoints {
  static const String baseUrl = 'https://test.myfliqapp.com/api/v1';

  // Auth
  static const String sendOtp =
      '$baseUrl/auth/registration-otp-codes/actions/phone/send-otp';
  static const String verifyOtp =
      '$baseUrl/auth/registration-otp-codes/actions/phone/verify-otp';

  // Chat
  static const String getChatProfiles = '$baseUrl/chat_profiles';
  static const String getMessages = '$baseUrl/chat_messages';
  static const String checkUser = '$baseUrl/chat_messages';

  // Add more as needed...
}
