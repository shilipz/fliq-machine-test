
class ApiEndpoints {
  static const String baseUrl = 'https://test.myfliqapp.com/api/v1';

  //================================= Auth
  static const String sendOtp =
      '$baseUrl/auth/registration-otp-codes/actions/phone/send-otp';
  static const String verifyOtp =
      '$baseUrl/auth/registration-otp-codes/actions/phone/verify-otp';

  // ----------------------------------------Chat
  static const String getChatProfiles =
      '$baseUrl/chat/chat-messages/queries/contact-users';
  static const String getMessages =
      '$baseUrl/chat/chat-messages/queries/chat-between-users';

}
