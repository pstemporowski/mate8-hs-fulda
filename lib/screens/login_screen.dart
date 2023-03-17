import 'package:Mate8/styles/static_colors.dart';
import 'package:Mate8/styles/static_styles.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/sign_in_controller.dart';
import 'background_screen.dart';
import '../components/components.dart';

class LoginScreen extends GetView<SignInController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(255, 26, 67, 77)));
    var screenHeight = MediaQuery.of(context).size.height;
    return Hero(
      tag: 'onGoingAnimation',
      child: Scaffold(
        backgroundColor: StaticColors.secondaryColor,
        body: SingleChildScrollView(
          child: ColumnSuper(
            children: [
              BackgroundScreen(
                height: screenHeight * 0.5,
                src: "assets/images/onboardingParty.png",
              ),
              Container(
                height: screenHeight * 0.5,
                decoration: BoxDecoration(
                    color: StaticColors.primaryColor,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(StaticStyles.borderRadius))),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "SignIn".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: StaticColors.secondaryFontColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField("Email".tr,
                          controller: controller.emailTextEditingController),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField("Password".tr,
                          controller: controller.passwordTextEditingController,
                          iconData: Icons.security),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton("GoBack".tr,
                              color: Colors.white, onTap: controller.goBack),
                          CustomButton("SignIn".tr,
                              color: Colors.white, onTap: controller.signIn),
                        ],
                      ),
                      Obx(
                        () => Text(
                          controller.errorText.value,
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
