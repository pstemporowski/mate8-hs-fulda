import 'package:Mate8/bindings/bindings.dart';
import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/model/model.dart';
import 'package:Mate8/screens/main_pages/profile_page.dart';
import 'package:Mate8/screens/single_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../components/components.dart';
import '../../styles/static_colors.dart';
import '../../styles/static_styles.dart';

class ChatsPage extends GetView<MatchesController> {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.primaryColor,
      appBar: const CustomAppBar(title: 'Chats'),
      body: Container(
        decoration: BoxDecoration(
            color: StaticColors.secondaryColor,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(StaticStyles.borderRadius))),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                    itemCount: controller.chats.length,
                    itemBuilder: (_, index) {
                      var chat = controller.chats[index];
                      var chatUser = chat.otherUser;
                      var currentUser = const types.User(
                          //Todo add the currentUser from Auth
                          id: '4cceb2b6-0955-4960-b67b-309ff1766b27');
                      var otherUser = types.User(
                          id: chatUser.id,
                          firstName: chatUser.name,
                          imageUrl: chatUser.profilePictureUrl);
                      final tag = 'ProfilePage:${chatUser.id}';
                      return ChatTile(
                          chat: chat,
                          chatUser: chatUser,
                          tagId: tag,
                          onTap: () => onTapChatTile(
                              currentUser, otherUser, chatUser, chat, tag));
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapChatTile(types.User currentUser, types.User otherUser,
      User otherUserModel, Chat chat, String tag) async {
    Get.to(
        () => SingleChatScreen(
            currentUser: currentUser,
            otherUser: otherUser,
            tagId: tag,
            textMessages: chat.messages,
            otherUserModel: otherUserModel,
            chatId: chat.id),
        binding: ChatBinding());
    if (chat.isNewMessageAdded.value) {
      controller.newMessagesCount--;
      chat.isNewMessageAdded.value = false;
    }
  }

  String formattedDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    bool isToday = DateTime.now().day == dateTime.day &&
        DateTime.now().month == dateTime.month &&
        DateTime.now().year == dateTime.year;
    if (isToday) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('dd.MM HH:mm').format(dateTime);
    }
  }
}
