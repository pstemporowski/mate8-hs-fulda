import 'package:Mate8/controller/sign_up_controller.dart';
import 'package:Mate8/screens/email_screen.dart';
import 'package:Mate8/screens/sing_up_details_screen.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../styles/static_colors.dart';
import '../styles/static_styles.dart';
import 'background_screen.dart';
import '../components/components.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: StaticColors.primaryColor));
    var screenHeight = MediaQuery.of(context).size.height;

    return Hero(
      tag: 'onGoingAnimation',
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(builder: (context) {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarColor: StaticColors.primaryColor));
          return SingleChildScrollView(
            child: ColumnSuper(
              children: [
                BackgroundScreen(
                  height: screenHeight * 0.5,
                  src: "assets/images/onboardingParty.png",
                ),
                Container(
                  height: screenHeight * 0.5,
                  decoration: const BoxDecoration(
                      color: StaticColors.primaryColor,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(StaticStyles.borderRadius))),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "SignUp".tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: StaticColors.secondaryFontColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField("Email".tr,
                              controller:
                                  controller.emailTextEditingController),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField("Password".tr,
                              isPassword: true,
                              controller:
                                  controller.passwordTextEditingController,
                              iconData: Icons.security),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton("Next".tr,
                              color: Colors.white, onTap: signUp),
                          const SizedBox(
                            height: 5,
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
                        ]),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controller.emailTextEditingController.text,
        password: controller.passwordTextEditingController.text,
      );

      Get.to(() => const EmailScreen());
    } on FirebaseAuthException catch (e) {
      controller.errorText.value = e.message ?? '';
    }
  }
}
