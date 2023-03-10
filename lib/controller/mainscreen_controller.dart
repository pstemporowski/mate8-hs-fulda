import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/pages/chats_page.dart';
import '../screens/pages/match_page.dart';
import '../screens/pages/profile_page.dart';

class MainScreenController extends GetxController {
  var activePageIndex = 0.obs;

  final List<Widget> tabItems = [
    MatchPage(),
    const ChatsPage(),
    const ProfilePage(),
    Container(),
  ];
}
