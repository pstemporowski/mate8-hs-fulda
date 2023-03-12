import 'dart:developer';
import 'package:Mate8/controller/mainscreen_controller.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/components.dart';
import '../model/model.dart';
import '../services/services.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MatchesController extends GetxController {
  var swiperController = AppinioSwiperController();
  var cards = <SwipeCard>[].obs;
  var users = <User>[];
  var chats = <Chat>[].obs;
  var newMessagesCount = 0.obs;
  var isControllerInit = false.obs;

  var testUserId = '4cceb2b6-0955-4960-b67b-309ff1766b27';
  var datastore = Get.find<Datastore>();
  var mainScreenController = Get.find<MainScreenController>();

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void onMatchSnackBarTapped(GetSnackBar snackBar) async {
    mainScreenController.activePageIndex.value = 1;
  }

  void onNewChat(Chat chat) async {
    chats.insert(0, chat);

    if (isControllerInit.value == false) {
      return;
    }

    showSnackBar();
  }

  void showSnackBar() {
    Get.showSnackbar(
      GetSnackBar(
        onTap: onMatchSnackBarTapped,
        margin: EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        title: 'Neuer Match',
        borderRadius: 15,
        snackPosition: SnackPosition.TOP,
        message: "Jetzt kannst du mit der Person chatten",
        backgroundColor: Colors.green,
        icon: Icon(
          FluentIcons.handshake_32_filled,
          color: Colors.white,
        ),
      ),
    );
    closeSnackBar(closeAfter: 5);
  }

  void closeSnackBar({int closeAfter = 0}) async {
    await Future.delayed(Duration(seconds: closeAfter));
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  void onNewMessage(types.TextMessage message, Chat chat) async {
    if (isControllerInit.value == false || message.author.id == testUserId) {
      return;
    }

    if (chat.isNewMessageAdded.value == false) {
      newMessagesCount++;
      chat.isNewMessageAdded.value = true;
    }
    _moveChatToTop(chat);
  }

  void _moveChatToTop(Chat chat) {
    chats.remove(chat);
    chats.add(chat);
  }

  void _loadData() async {
    isControllerInit.value = false;
    cards.clear();
    //var chats = await datastore.getChats('4cceb2b6-0955-4960-b67b-309ff1766b27');
    //TODO add current USer ID from Authentificator;
    await datastore.listenToChats(testUserId,
        onNewChat: onNewChat, onNewMessage: onNewMessage);
    var newCandidates = await datastore.getCandidateUsers(testUserId);
    for (var candidate in newCandidates) {
      cards.add(SwipeCard(candidate: candidate));
    }
    users = newCandidates;
    _finishLoad();
  }

  void _finishLoad() async {
    await Future.delayed(Duration(seconds: 1));
    isControllerInit.value = true;
    sortChats(chats);
  }

  void swipe(int index, AppinioSwiperDirection direction) {
    handleMatch(users[index], direction.name == 'left');
    users.removeAt(index);
  }

  void unswipe(bool unswiped) {
    if (unswiped) {
      log("SUCCESS: card was unswiped");
    } else {
      log("FAIL: no card left to unswipe");
    }
  }

  void handleMatch(User user, bool isMatch) async {
    print(user.id);
    //TODO Add UserID if verified
    datastore.uploadUserAction(
        currentUserId: testUserId, otherUserId: user.id, isMatch: isMatch);
  }

  Future<void> sortChats(List<Chat> chats) async {
    var now = DateTime.now().millisecondsSinceEpoch;

    chats.sort((a, b) {
      final lastMessageA = a.messages.isNotEmpty ? a.messages.first : null;
      final lastMessageB = b.messages.isNotEmpty ? b.messages.first : null;

      if (lastMessageA == null && lastMessageB == null) {
        return b.createdAt.compareTo(a.createdAt);
      } else {
        var aTimestamp = lastMessageA?.createdAt ?? a.createdAt;
        var bTimestamp = lastMessageB?.createdAt ?? b.createdAt;

        var aDifference = (now - aTimestamp).abs();
        var bDifference = (now - bTimestamp).abs();

        return aDifference.compareTo(bDifference);
      }
    });
  }
}
