import 'package:Mate8/bindings/bindings.dart';
import 'package:Mate8/screens/sign_in_screen.dart';
import 'package:Mate8/screens/sign_up_screen.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../components/components.dart';
import '../styles/static_colors.dart';
import 'background_screen.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: StaticColors.secondaryColor));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 0,
        ),
        backgroundColor: Colors.white,
        // Set the system UI overlay style here
        extendBody: true,
        body: Builder(builder: (context) {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarColor: StaticColors.secondaryColor));
          return OnBoardingSlider(
            headerBackgroundColor: Colors.white,
            finishButtonText: 'SignUp'.tr,
            onFinish: onSignUpTapped,
            finishButtonStyle: const FinishButtonStyle(
                backgroundColor: StaticColors.primaryColor,
                foregroundColor: StaticColors.secondaryColor),
            skipTextButton: const Icon(
              FluentIcons.fast_forward_16_regular,
              color: StaticColors.primaryFontColor,
            ),
            trailing: GestureDetector(
                onTap: onSignInTapped, child: Text('SignIn'.tr)),
            background: [
              Image.asset('assets/images/onboardingSearch.png', height: 400),
              Image.asset('assets/images/onboardingChatting.png', height: 400),
              Image.asset('assets/images/onboardingParty.png', height: 400),
            ],
            totalPage: 3,
            pageBackgroundColor: Colors.white,
            speed: 1.8,
            pageBodies: [
              onBoardingPageBody(
                  title: 'ExploreNewPeopleTitle'.tr,
                  content: 'ExploreNewPeopleContent'.tr),
              onBoardingPageBody(
                  title: 'EasyChattingTitle'.tr,
                  content: 'EasyChattingContent'.tr),
              Hero(
                tag: 'onGoingAnimation',
                child: onBoardingPageBody(
                    title: 'FindPartyFriendTitle'.tr,
                    content: 'FindPartyFriendContent'.tr),
              )
            ],
          );
        }));
  }

  Widget onBoardingPageBody({
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 400,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: StaticColors.primaryFontColor,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black26,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSignUpTapped() async {
    Get.to(() => SignUpScreen());
  }

  void onSignInTapped() async {
    Get.to(() => const SignInScreen());
  }
}
