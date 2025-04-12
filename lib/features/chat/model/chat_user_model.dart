class ChatProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String profilePhoto;
  final String lastMessageAt;
  final String? currentUserId; // nullable for safety

  ChatProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.profilePhoto,
    required this.lastMessageAt,
    this.currentUserId,
  });

  factory ChatProfile.fromJson(Map<String, dynamic> json) {
    return ChatProfile(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      profilePhoto: json['profile_photo_url'] ?? '',
      lastMessageAt: json['message_received_from_partner_at'] ?? '',
      currentUserId: json['auth_user_id'].toString(),
    );
  }
}
