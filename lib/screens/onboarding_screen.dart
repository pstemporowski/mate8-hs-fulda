import 'package:Mate8/screens/login_screen.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/components.dart';
import '../styles/static_colors.dart';
import 'background_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: StaticColors.primaryColor,
      body: ColumnSuper(
        children: [
          BackgroundScreen(height: screenHeight * 0.7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  "MATE8",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: StaticColors.secondaryFontColor,
                      fontSize: 30),
                ),
                Text(
                  "ForStudents".tr,
                  style: TextStyle(
                      color: StaticColors.secondaryFontColor, fontSize: 18),
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton('GettingStarted'.tr, color: Colors.white),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("ExistingAccount".tr,
                            style: const TextStyle(color: Colors.grey)),
                        GestureDetector(
                            onTap: () async => Get.to(LoginScreen()),
                            child: Text("SignInNow".tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)))
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
