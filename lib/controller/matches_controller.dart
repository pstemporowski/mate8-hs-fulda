import 'dart:developer';
import 'dart:ffi';
import 'package:Mate8/model/SwipeCard.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/model.dart';
import '../services/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MatchesController extends GetxController {
  var swiperController = AppinioSwiperController();
  var cards = <Widget>[].obs;
  var chats = <Chat>[].obs;
  var candidates = <User>[];
  final datastore = Datastore();

  @override
  void onInit() {
    super.onInit();
    _loadCards();
  }

  void onNewChat(Chat chat) {
    chats.add(chat);
  }

  void onNewMessages(types.Message message, Chat chat) {
    chat.timestamp = message.createdAt ?? DateTime.now() as int;
  }

  void _loadCards() async {
    cards.clear();
    //var chats = await datastore.getChats('4cceb2b6-0955-4960-b67b-309ff1766b27');
    await datastore.listenToChats('4cceb2b6-0955-4960-b67b-309ff1766b27',
        onNewChat: onNewChat, onNewMessage: onNewMessages);
    print((chats.length));
    var newCandidates = await datastore.getCandidateUsers();

    for (var candidate in newCandidates) {
      cards.add(SwipeCard(candidate: candidate));
    }

    candidates = newCandidates;
  }

  void swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
  }

  void unswipe(bool unswiped) {
    if (unswiped) {
      log("SUCCESS: card was unswiped");
    } else {
      log("FAIL: no card left to unswipe");
    }
  }
}
