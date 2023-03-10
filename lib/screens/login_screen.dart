import 'dart:math';
import 'package:Mate8/styles/static_colors.dart';
import 'package:Mate8/styles/static_styles.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'background_screen.dart';
import '../components/components.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: StaticColors.primaryColor,
      body: SingleChildScrollView(
        child: ColumnSuper(
          innerDistance: -50,
          children: [
            BackgroundScreen(height: screenHeight * 0.7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SignIn".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: StaticColors.secondaryFontColor,
                        fontSize: 30),
                  ),
                  CustomTextFormField("Email".tr, controller: _emailController),
                  CustomTextFormField("Password".tr,
                      controller: _passwordController,
                      iconData: Icons.security),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton("GoBack".tr,
                          color: Colors.white, onTap: signIn),
                      CustomButton("SignIn".tr,
                          color: Colors.white, onTap: signIn),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
