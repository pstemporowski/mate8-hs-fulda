import 'dart:async';
import 'package:Mate8/controller/current_user_controller.dart';
import 'package:Mate8/screens/email_screen.dart';
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

class VerifyScreen extends GetView<CurrentUserController> {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.setUserDetails(FirebaseAuth.instance.currentUser?.uid ?? "");
    return Obx(
      () => controller.isCurrentUserSet.value
          ? MainScreen()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
