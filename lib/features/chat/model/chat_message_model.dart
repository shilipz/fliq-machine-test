class ChatMessage {
  final int id;
  final int chatThreadId;
  final int chatMessageTypeId;
  final int senderId;
  final int receiverId;
  final String message;
  final String? mediaUrl;
  final DateTime sentAt;
  final int currentUserId;

  ChatMessage({
    required this.id,
    required this.chatThreadId,
    required this.chatMessageTypeId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentAt,
    required this.currentUserId,
    this.mediaUrl,
  });

  bool get isSender => currentUserId == senderId;
  String get text => message;

  factory ChatMessage.fromJson(Map<String, dynamic> json, int currentUserId) {
    return ChatMessage(
      id: int.parse(json['id'].toString()),
      chatThreadId: json['chat_thread_id'],
      chatMessageTypeId: json['chat_message_type_id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'] ?? '',
      sentAt: DateTime.parse(json['sent_at']),
      mediaUrl: json['media_url'],
      currentUserId: currentUserId,
    );
  }
}
