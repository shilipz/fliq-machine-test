import 'package:fliq/features/chat/presentation/widgets/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fliq/core/widgets/common_widgets.dart';
import 'package:fliq/features/chat/presentation/controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String chatUserId;
  final String currentUserId;
  final String profilePhoto;
  const ChatScreen({
    super.key,
    required this.name,
    required this.chatUserId,
    required this.currentUserId,
    required this.profilePhoto,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchMessages(
        int.parse(widget.currentUserId),
        int.parse(
          widget.chatUserId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(widget.name),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.messages.isEmpty) {
                return const Center(child: Text('No messages yet.'));
              } else {
                final reversedMessages = controller.messages.toList();

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    itemCount: reversedMessages.length,
                    itemBuilder: (context, index) {
                      bool _isSameDay(DateTime a, DateTime b) {
                        return a.year == b.year &&
                            a.month == b.month &&
                            a.day == b.day;
                      }

                      final msg = reversedMessages[index];
                      final msgDate = DateTime.parse(msg.sentAt.toString());

                      final showDateHeader = index == 0 ||
                          !_isSameDay(
                            DateTime.parse(
                                reversedMessages[index - 1].sentAt.toString()),
                            msgDate,
                          );

                      return Column(
                        crossAxisAlignment: msg.isSender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (showDateHeader)
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  getDateLabel(msgDate),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ),
                            ),
                          msg.isSender
                              ? buildSenderBubble(
                                  msg.text, msg.sentAt.toString())
                              : buildReceiverBubble(
                                  msg.text, msg.sentAt.toString()),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                );
              }
            }),
          ),
          _buildChatInput(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(final name) {
    return AppBar(
      surfaceTintColor: const Color(0xFFF7F7F7),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const CustomArrowBack(),
      ),
      toolbarHeight: 80,
      title: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: widget.profilePhoto.isNotEmpty
                ? NetworkImage(widget.profilePhoto)
                : const AssetImage('assets/images/avatar_0.jpg')
                    as ImageProvider,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                capitalize(name),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Online',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChatInput(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      size: 22,
                      Icons.send_rounded,
                      color: Colors.deepOrange,
                    ),
                    isDense: true,
                    hintText: 'Type something...',
                    border: InputBorder.none,
                    hintStyle:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
