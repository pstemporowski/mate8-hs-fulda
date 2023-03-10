import 'dart:developer';
import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:get/get.dart';
import '../../model/SwipeCard.dart';

class MatchPage extends GetView<MatchesController> {
  MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => AppinioSwiper(
                unlimitedUnswipe: true,
                controller: controller.swiperController,
                unswipe: controller.unswipe,
                cards: controller.cards.value,
                onSwipe: controller.swipe,
              ),
            ),
          ),
        ],
      ),
    );
  }


}
