import 'package:Mate8/controller/routing_controller.dart';
import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/services/services.dart';
import 'package:Mate8/styles/static_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:badges/badges.dart' as badges;

class MainScreen extends GetView<RoutingController> {
  MainScreen({Key? key}) : super(key: key);
  final matchesController = Get.find<MatchesController>();

  @override
  Widget build(BuildContext context) {
    final tabItems = controller.tabItems();
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
                    icon: Obx(
                          () => badges.Badge(
                        badgeAnimation: const badges.BadgeAnimation.slide(),
                        badgeContent: Text(
                            matchesController.newMessagesCount.value.toString(),
                            style:
                            TextStyle(color: StaticColors.secondaryFontColor)),
                        showBadge: matchesController.newMessagesCount.value > 0,
                        child: Icon(FluentIcons.chat_32_regular,
                            color: StaticColors.mainIconColor),
                      ),
                    ),
                    title: Text("Chats".tr),
                    selectedColor: StaticColors.primaryColor,
                    activeIcon: Obx(
                          () => badges.Badge(
                        badgeContent: Text(
                            matchesController.newMessagesCount.value.toString(),
                            style:
                            TextStyle(color: StaticColors.secondaryFontColor)),
                        badgeAnimation: const badges.BadgeAnimation.slide(),
                        showBadge: matchesController.newMessagesCount.value > 0,
                        child: Icon(FluentIcons.chat_32_filled,
                            color: StaticColors.mainIconColor),
                      ),
                    ),
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
            children: tabItems,
          ),
        ));
  }
}
