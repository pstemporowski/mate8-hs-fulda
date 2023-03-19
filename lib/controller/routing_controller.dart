import 'package:Mate8/components/components.dart';
import 'package:Mate8/controller/current_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/main_pages/chats_page.dart';
import '../screens/main_pages/match_page.dart';
import '../screens/main_pages/profile_page.dart';
import '../screens/main_pages/settings_page.dart';

class RoutingController extends GetxController {
  final currentUserController = Get.find<CurrentUserController>();

  var activePageIndex = 0.obs;

  List<Widget> tabItems() {
    return [
      const MatchPage(),
      const ChatsPage(),
      ProfilePage(
        currentUserController.currentUser!,
        showProfileImage: true,
      ),
      const SettingsPage()
    ];
  }
}
