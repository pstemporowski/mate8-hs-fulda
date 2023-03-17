import 'package:Mate8/controller/current_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/pages/chats_page.dart';
import '../screens/pages/match_page.dart';
import '../screens/pages/profile_page.dart';

class MainScreenController extends GetxController {
  final currentUserController = Get.find<CurrentUserController>();
  var activePageIndex = 0.obs;

  List<Widget> tabItems() => [
        MatchPage(),
        const ChatsPage(),
        ProfilePage(currentUserController.currentUser!),
        Container(),
      ];
}
