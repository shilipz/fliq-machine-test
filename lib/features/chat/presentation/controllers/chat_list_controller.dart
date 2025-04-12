import 'dart:developer';

import 'package:fliq/features/chat/data/services/chat_list_service.dart';
import 'package:fliq/features/chat/model/chat_user_model.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final ChatListService _chatService = ChatListService();

  RxList<ChatProfile> chatProfiles = <ChatProfile>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    fetchProfiles();
    super.onInit();
  }

  void fetchProfiles() async {
    try {
      isLoading.value = true;
      final profiles = await _chatService.fetchChatProfiles();
      chatProfiles.assignAll(profiles);
      log('Profiles: $profiles');
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
