import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../bindings/chat_binding.dart';
import '../model/model.dart';
import '../screens/chat_screen.dart';
import '../services/services.dart';

class ChatController extends GetxController {
  var currentUser =
      const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  var otherUser = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3aD');
  var messages = <types.TextMessage>[].obs;
  var datastore = Get.find<Datastore>();
  var chatId = '';

  void loadMessages() async {
    for (int i = 0; i < 20; i++) {
      addMessage(types.TextMessage(
          author: otherUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: randomString(),
          text: "test"));
    }
  }

  void addMessage(types.TextMessage message) async {
    datastore.uploadMessage(chatId, message);
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    addMessage(textMessage);
  }
}
