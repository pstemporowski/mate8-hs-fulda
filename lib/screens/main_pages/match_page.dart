import 'dart:developer';
import 'package:Mate8/components/components.dart';
import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/styles/static_colors.dart';
import 'package:Mate8/styles/static_styles.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchPage extends GetView<MatchesController> {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const Pad(bottom: 80),
      decoration: const BoxDecoration(
          color: StaticColors.primaryColor,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(StaticStyles.borderRadius))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: 'Matches'.tr),
        extendBody: true,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(StaticStyles.borderRadius))),
                child: Obx(
                  () => controller.isLoading.value
                      ? _loadingScreen()
                      : controller.cardsAvailable.value
                          ? _buildCardsAvailableView()
                          : _buildNoCardsAvailableView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(
        color: StaticColors.primaryColor,
      ),
    );
  }

  Widget _buildNoCardsAvailableView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('NoUserAvailable'.tr),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: CustomButton(
            'Reload'.tr,
            color: StaticColors.primaryColor,
            fontColor: Colors.white,
            onTap: controller.onRefreshButtonTapped,
          ),
        )
      ],
    );
  }

  Widget _buildCardsAvailableView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: AppinioSwiper(
            controller: controller.swiperController,
            onSwipe: controller.swipe,
            cards: controller.cards,
            onEnd: controller.onSwiperEnded,
            cardsBuilder: (BuildContext context, int index) {
              return controller.cards
              ,
            },
          ),
        ),
        _buildMatchControlPanel(),
        Container(
          height: 5,
          color: Colors.white,
        )
      ],
    );
  }

  Widget _buildMatchControlPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRoundedIconButton(
            backgroundColor: Colors.red,
            icon: FluentIcons.dismiss_32_regular,
            onTap: controller.onDismissTapped),
        _buildRoundedIconButton(
            backgroundColor: Colors.green,
            icon: FluentIcons.checkmark_32_regular,
            onTap: controller.onMatchTapped),
      ],
    );
  }

  Widget _buildRoundedIconButton(
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
