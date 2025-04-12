import 'dart:developer';

import 'package:fliq/core/utils/responsive.dart';
import 'package:fliq/features/chat/presentation/controllers/chat_list_controller.dart';
import 'package:fliq/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fliq/core/widgets/common_widgets.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  final ChatListController controller = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(responsive.widthPercentage(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomArrowBack(),
                  SizedBox(width: responsive.widthPercentage(4)),
                  Text(
                    'Messages',
                    style: GoogleFonts.poppins(
                      fontSize: responsive.widthPercentage(4),
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsive.heightPercentage(2.5)),
              Obx(() {
                if (controller.chatProfiles.isEmpty) {
                  return const SizedBox.shrink();
                }

                return SizedBox(
                  height: responsive.heightPercentage(12),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.chatProfiles.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(width: responsive.widthPercentage(4)),
                    itemBuilder: (context, index) {
                      final profile = controller.chatProfiles[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsive.widthPercentage(1.5)),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: responsive.widthPercentage(7),
                              backgroundImage: profile.profilePhoto.isNotEmpty
                                  ? NetworkImage(profile.profilePhoto)
                                  : const AssetImage(
                                          'assets/images/avatar_1.jpg')
                                      as ImageProvider,
                            ),
                            SizedBox(height: responsive.heightPercentage(1)),
                            Text(
                              capitalize(profile.name),
                              style: GoogleFonts.poppins(
                                fontSize: responsive.widthPercentage(3.2),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: responsive.heightPercentage(2)),
              Container(
                height: responsive.heightPercentage(6),
                padding: EdgeInsets.symmetric(
                    horizontal: responsive.widthPercentage(4)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: TextField(
                    onChanged: (value) => controller.filterProfiles(value),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsive.heightPercentage(2)),
              Text(
                'Chat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.widthPercentage(3),
                ),
              ),
              SizedBox(height: responsive.heightPercentage(1)),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.error.isNotEmpty) {
                    log('message: ${controller.error.value}');
                    return Center(
                        child: Text(
                      controller.error.value,
                      style: const TextStyle(color: Colors.red),
                    ));
                  } else if (controller.chatProfiles.isEmpty) {
                    return const Center(child: Text("No chats found"));
                  } else if (controller.filteredProfiles.isEmpty) {
                    return const Center(child: Text("No results found "));
                  }

                  return ListView.separated(
                    itemCount: controller.filteredProfiles.length,
                    separatorBuilder: (_, __) => Divider(
                        color: const Color.fromARGB(255, 248, 246, 246),
                        height: responsive.heightPercentage(4)),
                    itemBuilder: (context, index) {
                      final profile = controller.filteredProfiles[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: responsive.widthPercentage(7),
                          backgroundImage: profile.profilePhoto.isNotEmpty
                              ? NetworkImage(profile.profilePhoto)
                              : const AssetImage('assets/images/avatar_0.jpg')
                                  as ImageProvider,
                        ),
                        title: Text(
                          capitalize(profile.name),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: responsive.widthPercentage(4),
                          ),
                        ),
                        trailing: Text(
                          formatTime(profile.lastMessageAt),
                          style: TextStyle(
                            fontSize: responsive.widthPercentage(3),
                            color: Colors.black54,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                profilePhoto: profile.profilePhoto,
                                currentUserId: profile.currentUserId.toString(),
                                chatUserId: profile.id,
                                name: profile.name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
