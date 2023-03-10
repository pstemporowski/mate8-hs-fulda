import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'background_screen.dart';
import '../components/components.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundScreen(),
          Padding(
            padding: const EdgeInsets.only(top: 220, left: 35, right: 35),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "SignUp".tr,
                    style: const TextStyle(
                        fontFamily: "Oswald",
                        color: Colors.white,
                        fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField("Email".tr,
                        controller: _emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField("Password".tr,
                        controller: _passwordController,
                        iconData: Icons.security),
                  ),
                  GestureDetector(
                      onTap: () => signUp(), child: CustomButton("SignUp".tr)),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CustomButton("Abort".tr, color: Colors.grey))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
