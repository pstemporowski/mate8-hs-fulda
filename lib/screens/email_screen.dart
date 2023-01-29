import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:input_form_field/input_form_field.dart';
import 'package:flutter/foundation.dart';


import 'background_screen.dart';
import 'components.dart';
import 'main_screen.dart';

class EmailScreen extends StatefulWidget {
  EmailScreen({Key? key}) : super(key: key);

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
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MainScreen()
      : Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              BackgroundScreen(),
              Padding(
                padding: const EdgeInsets.only(top: 250, left: 35, right: 35),
                child: Container(
                    child: Center(
                  child: Column(
                    children: [
                      Text(
                          "Email Verifiezieren!",
                          style: TextStyle(
                              fontFamily: "Oswald",
                              color: Colors.white,
                              fontSize: 28),
                        ),
                        Text(
                          "Um die App nutzen zu können, müssen Sie sich verifizieren! Sie habe eine e-Mail mit einem Link erhalten",
                          style: TextStyle(
                              fontFamily: "Oswald",
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        Components.GetButton("bereits Verifiziert"),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Components.GetButton("Abbrechen", Colors.grey))
                    ],
                  ),
                )),
              )
            ],
          ),
        );

  Future checkEmailVerified() async {
    var user = await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }
}
