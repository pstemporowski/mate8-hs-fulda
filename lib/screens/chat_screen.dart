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
      required this.textMessages})
      : super(key: key);

  final types.User currentUser;
  final types.User otherUser;
  final RxList<types.TextMessage> textMessages;

  @override
  Widget build(BuildContext context) {
    controller.currentUser = currentUser;
    controller.otherUser = otherUser;
    controller.messages = textMessages;
    return Scaffold(
      body: Container(
        child: Obx(
          () => Chat(
            showUserNames: true,
            showUserAvatars: true,
            messages: controller.messages.value,
            onSendPressed: controller.handleSendPressed,
            user: currentUser,
            bubbleBuilder: _bubbleBuilder,
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
        padding: BubbleEdges.all(0),
        color: currentUser.id != message.author.id ||
                message.type == types.MessageType.image
            ? const Color(0xfff5f5f7)
            : const Color(0xff6f61e8),
        margin: nextMessageInGroup
            ? const BubbleEdges.symmetric(horizontal: 6)
            : null,
        nip: nextMessageInGroup
            ? BubbleNip.no
            : currentUser.id != message.author.id
                ? BubbleNip.leftBottom
                : BubbleNip.rightBottom,
        child: child,
      );
}
