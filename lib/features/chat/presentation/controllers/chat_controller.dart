import 'package:fliq/features/chat/data/services/chat_service.dart';
import 'package:fliq/features/chat/model/chat_message_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();
  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;

  Future<void> fetchMessages(int currentUserId, int userId) async {
    try {
      isLoading.value = true;
      final result = await _chatService.getChatMessages(currentUserId, userId);
      messages.assignAll(result);
    } catch (e) {
      print('Error fetching chat messages: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
