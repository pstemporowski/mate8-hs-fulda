import 'dart:developer';
import 'package:Mate8/controller/routing_controller.dart';
import 'package:Mate8/screens/main_pages/profile_page.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import '../components/components.dart';
import '../model/model.dart' as model;
import '../services/services.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MatchesController extends GetxController {
  //Hotfix because AppinioSwiper Disposed automatically
  final swiperController = Get.put(AppinioSwiperController());
  var datastore = Get.find<Datastore>();
  var mainScreenController = Get.find<RoutingController>();
  var cards = <SwipeCard>[].obs;
  var chats = <model.Chat>[].obs;
  var users = <model.User>[];
  var newMessagesCount = 0.obs;
  var isControllerInit = false.obs;
  var cardsAvailable = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void onMatchSnackBarTapped(GetSnackBar snackBar) async {
    mainScreenController.activePageIndex.value = 1;
  }

  void onNewChat(model.Chat chat) async {
    chats.insert(0, chat);

    if (isControllerInit.value == false) {
      return;
    }
    chat.isNewMessageAdded.value = true;
    newMessagesCount++;
    showSnackBar();
  }

  void showSnackBar() {
    Get.showSnackbar(
      GetSnackBar(
        onTap: onMatchSnackBarTapped,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        title: 'NewMatch'.tr,
        borderRadius: 15,
        snackPosition: SnackPosition.TOP,
        message: 'ChatNow'.tr,
        backgroundColor: Colors.green,
        icon: const Icon(
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

  void onNewMessage(types.TextMessage message, model.Chat chat) async {
    if (isControllerInit.value == false) return;
    _moveChatToTop(chat);

    if (message.author.id == FirebaseAuth.instance.currentUser!.uid) return;

    if (chat.isNewMessageAdded.value == false) {
      newMessagesCount++;
      chat.isNewMessageAdded.value = true;
    }
  }

  void _moveChatToTop(model.Chat chat) {
    chats.remove(chat);
    chats.insert(0, chat);
  }

  Future _loadData() async {
    isLoading.value = true;
    isControllerInit.value = false;
    cards.clear();
    await datastore.listenToChats(FirebaseAuth.instance.currentUser!.uid,
        onNewChat: onNewChat, onNewMessage: onNewMessage);

    await _loadNewCandidates();

    _finishLoad();

    isLoading.value = false;
  }

  Future _loadNewCandidates() async {
    var newCandidates = await datastore
        .getCandidateUsers(FirebaseAuth.instance.currentUser!.uid);
    newCandidates
        .map((candidate) => cards.add(SwipeCard(candidate: candidate)))
        .toList();
    users = newCandidates;

    if (cards.isNotEmpty) cardsAvailable.value = true;
  }

  void _finishLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    isControllerInit.value = true;
    sortChats(chats);
  }

  void onMatchTapped() async {
    swiperController.swipe();
  }

  void onDismissTapped() async {
    if (isClosed) return;

    swiperController.swipeLeft();
  }

  void swipe(int index, AppinioSwiperDirection direction) async {
    handleMatch(users[index], direction.name == 'right');
    users.removeAt(index);
  }

  void handleMatch(model.User user, bool isMatch) async {
    //TODO Add UserID if verified
    datastore.uploadUserAction(
        currentUserId: FirebaseAuth.instance.currentUser!.uid,
        otherUserId: user.id,
        isMatch: isMatch);
  }

  Future<void> sortChats(List<model.Chat> chats) async {
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

  void onSwiperEnded() async {
    cardsAvailable.value = false;
  }

  void onRefreshButtonTapped() async {
    isLoading.value = true;
    await _loadNewCandidates();
    isLoading.value = false;
  }
}
