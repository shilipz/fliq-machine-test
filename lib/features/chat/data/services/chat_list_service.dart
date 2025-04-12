import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fliq/core/constants/api_endpoints.dart';
import 'package:fliq/core/services/storage_service.dart';
import 'package:fliq/features/chat/model/chat_user_model.dart';
import 'package:japx/japx.dart';

class ChatListService {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    },
  ));

  Future<List<ChatProfile>> fetchChatProfiles() async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        throw Exception('No token found in local storage');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';
      print('Token: $token'); // print the token for debugging
      final response = await _dio.get(ApiEndpoints.getChatProfiles);

      // print the raw JSON response
      print('Raw API Response: ${response.data}');

      final decoded = Japx.decode(response.data);

      // print the decoded JSON (flattened structure)
      print('Decoded Response: $decoded');

      final List<dynamic> profiles = decoded['data'];

      // Optional: print each profile
      for (var p in profiles) {
        print('Profile: $p');
      }

      return profiles.map((e) => ChatProfile.fromJson(e)).toList();
    } catch (e, stacktrace) {
      log('Failed to load chat profiles: $e', stackTrace: stacktrace);
      throw Exception('Failed to load chat profiles: $e');
    }
  }
}
