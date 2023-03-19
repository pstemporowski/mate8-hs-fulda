import 'dart:convert';
import 'dart:math';
import 'package:Mate8/controller/chat_controller.dart';
import 'package:Mate8/screens/main_pages/profile_page.dart';
import 'package:Mate8/styles/static_styles.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';

import '../model/model.dart';

class SingleChatScreen extends GetView<ChatController> {
  const SingleChatScreen(
      {Key? key,
      this.tagId,
      required this.currentUser,
      required this.otherUser,
      required this.otherUserModel,
      required this.textMessages,
      required this.chatId})
      : super(key: key);

  final types.User currentUser;
  final types.User otherUser;
  final User otherUserModel;
  final String chatId;
  final RxList<types.TextMessage> textMessages;
  final String? tagId;

  @override
  Widget build(BuildContext context) {
    controller.currentUser = currentUser;
    controller.otherUser = otherUser;
    controller.messages = textMessages;
    controller.chatId = chatId;
    print(tagId);
    return Scaffold(
      appBar: ProfileAppBar(
          name: otherUser.firstName ?? "",
          profileImageUrl: otherUser.imageUrl ?? "",
          tag: tagId ?? ''),
      body: Obx(
        () => chat_ui.Chat(
          showUserNames: false,
          showUserAvatars: false,
          messages: controller.messages.value,
          onSendPressed: controller.handleSendPressed,
          user: currentUser,
          bubbleBuilder: _bubbleBuilder,
        ),
      ),
    );
  }

  AppBar ProfileAppBar(
      {required String name,
      required String profileImageUrl,
      required String tag}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Hero(
          tag: tag,
          child: Material(
            borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async => Get.to(() =>
                          ProfilePage(otherUserModel, showProfileImage: true)),
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(profileImageUrl),
                              maxRadius: 20,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) =>
      Bubble(
        shadowColor: Colors.transparent,
        padding: const BubbleEdges.all(0),
        margin: const BubbleEdges.all(0),
        style: const BubbleStyle(radius: Radius.circular(25)),
        color: currentUser.id != message.author.id ||
                message.type == types.MessageType.image
            ? const Color(0xfff5f5f7)
            : const Color(0xff6f61e8),
        nip: BubbleNip.no,
        child: child,
      );
}
