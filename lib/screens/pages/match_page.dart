import 'dart:developer';
import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/model/model.dart';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';

class MatchPage extends GetView<MatchesController> {
  MatchPage({Key? key}) : super(key: key);
  final appinioSwiperController = Get.find<AppinioSwiperController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: AppinioSwiper(
              controller: appinioSwiperController,
              onSwipe: controller.swipe,
              cards: controller.cards,
            ),
          ),
          Obx(
            () => controller.cards.isNotEmpty.obs.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedIconButton(
                          backgroundColor: Colors.red,
                          icon: FluentIcons.dismiss_32_regular,
                          onTap: controller.onDismissTapped),
                      RoundedIconButton(
                          backgroundColor: Colors.green,
                          icon: FluentIcons.checkmark_32_regular,
                          onTap: controller.onMatchTapped),
                    ],
                  )
                : Container(),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget RoundedIconButton(
      {required Color backgroundColor,
      Function()? onTap,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
