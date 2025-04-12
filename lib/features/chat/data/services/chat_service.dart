import 'package:dio/dio.dart';
import 'package:fliq/core/constants/api_endpoints.dart';
import 'package:fliq/core/services/storage_service.dart';
import 'package:fliq/features/chat/model/chat_message_model.dart';
import 'package:japx/japx.dart';

class ChatService {
  final Dio _dio = Dio();

  Future<List<ChatMessage>> getChatMessages(currentUserId, userId) async {
    final String url = '${ApiEndpoints.getMessages}/$userId/$currentUserId';

    try {
      final token = await StorageService.getToken();

      if (token == null) {
        throw Exception('No token found in local storage');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get(url);

      final japxData = Japx.decode(response.data);
      final List<dynamic> data = japxData['data'];

      final List<ChatMessage> messages =
          data.map((e) => ChatMessage.fromJson(e, currentUserId)).toList();

      return messages;
    } catch (e) {
      throw Exception('Failed to fetch chat messages: $e');
    }
  }
}
