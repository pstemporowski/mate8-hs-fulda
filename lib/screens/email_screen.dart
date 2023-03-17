import 'dart:async';
import 'package:Mate8/screens/sing_up_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/static_colors.dart';
import '../styles/static_styles.dart';
import 'background_screen.dart';
import '../components/components.dart';
import 'main_screen.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

Timer? timer;

class _EmailScreenState extends State<EmailScreen> {
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          title: Text('Details'.tr,
              style: TextStyle(color: StaticColors.primaryFontColor)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(StaticStyles.borderRadius)),
                color: StaticColors.primaryColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.info_12_regular,
                    color: StaticColors.secondaryFontColor,
                    size: 100,
                  ),
                  Text(
                    "EmailVerifyTitle".tr,
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                  Text(
                    'EmailVerifyContent'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  CustomButton(
                    "AlreadyVerified".tr,
                    color: StaticColors.secondaryColor,
                  ),
                ],
              ),
            )),
      );

  Future checkEmailVerified() async {
    var user = await FirebaseAuth.instance.currentUser!.reload();
    if (FirebaseAuth.instance.currentUser?.emailVerified ?? false == false) {
      Get.offAll(() => const SignUpDetailScreen());
    }
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }
}
