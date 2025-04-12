import 'dart:developer';
import 'package:fliq/features/chat/data/services/chat_list_service.dart';
import 'package:fliq/features/chat/model/chat_user_model.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final ChatListService _chatService = ChatListService();

  RxList<ChatProfile> chatProfiles = <ChatProfile>[].obs;
  RxList<ChatProfile> filteredProfiles = <ChatProfile>[].obs;

  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxString searchQuery = ''.obs;

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
      filteredProfiles.assignAll(profiles);
      log('Profiles: $profiles');
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void filterProfiles(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProfiles.assignAll(chatProfiles);
    } else {
      filteredProfiles.assignAll(chatProfiles.where((profile) =>
          profile.name.toLowerCase().contains(query.toLowerCase())));
    }
  }
}
