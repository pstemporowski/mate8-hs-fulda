import 'dart:convert';
import 'dart:math';
import 'package:Mate8/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen(
      {Key? key,
      required this.currentUser,
      required this.otherUser,
      required this.textMessages,
      required this.chatId})
      : super(key: key);

  final types.User currentUser;
  final types.User otherUser;
  final String chatId;
  final RxList<types.TextMessage> textMessages;

  @override
  Widget build(BuildContext context) {
    controller.currentUser = currentUser;
    controller.otherUser = otherUser;
    controller.messages = textMessages;
    controller.chatId = chatId;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
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
                CircleAvatar(
                  backgroundImage: NetworkImage(otherUser.imageUrl ?? ""),
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
                        otherUser.firstName ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => Chat(
          showUserNames: false,
          showUserAvatars: true,
          messages: controller.messages.value,
          onSendPressed: controller.handleSendPressed,
          user: currentUser,
          bubbleBuilder: _bubbleBuilder,
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
