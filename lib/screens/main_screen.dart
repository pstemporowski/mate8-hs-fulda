import 'package:Mate8/controller/mainscreen_controller.dart';
import 'package:Mate8/styles/static_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'pages/chats_page.dart';
import 'pages/match_page.dart';
import 'pages/profile_page.dart';
import 'pages/profile_set_up_page.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({Key? key}) : super(key: key);

  final bool isDone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CupertinoColors.white,
        bottomNavigationBar: Obx(
          () => SalomonBottomBar(
            currentIndex: controller.activePageIndex.value,
            onTap: (x) async => {controller.activePageIndex.value = x},
            items: [
              SalomonBottomBarItem(
                icon: const Icon(
                  FluentIcons.home_32_regular,
                  color: Colors.black,
                ),
                activeIcon: const Icon(FluentIcons.home_32_filled),
                title: Text("Home".tr),
                selectedColor: StaticColors.primaryColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(FluentIcons.chat_32_regular,
                    color: StaticColors.mainIconColor),
                title: Text("Chats".tr),
                selectedColor: StaticColors.primaryColor,
                activeIcon: const Icon(FluentIcons.chat_32_filled),
              ),
              SalomonBottomBarItem(
                icon: Icon(FluentIcons.person_32_regular,
                    color: StaticColors.mainIconColor),
                activeIcon: const Icon(FluentIcons.person_32_filled),
                title: Text("Profile".tr),
                selectedColor: StaticColors.primaryColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(FluentIcons.settings_28_regular,
                    color: StaticColors.mainIconColor),
                activeIcon: const Icon(FluentIcons.settings_28_filled),
                title: Text("Settings".tr),
                selectedColor: StaticColors.primaryColor,
              ),
            ],
          ),
        ),
        body: Obx(
          () => IndexedStack(
            index: controller.activePageIndex.value,
            children: controller.tabItems,
          ),
        ));
  }
}
