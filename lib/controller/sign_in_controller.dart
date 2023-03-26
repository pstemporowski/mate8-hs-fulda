import 'package:Mate8/screens/verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();
  var errorText = ''.obs;

  void goBack() async {
    Get.back();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text);
      Get.offAll(() => const VerifyScreen());
    } on FirebaseAuthException catch (e) {
      errorText.value = e.message ?? '';
    }
  }
}
