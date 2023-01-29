import 'dart:math';

import 'package:flutter/material.dart';
import 'package:input_form_field/input_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'background_screen.dart';
import 'components.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundScreen(),
          Padding(
            padding: const EdgeInsets.only(top: 220, left: 35, right: 35),
            child: Container(
                child: Center(
              child: Column(
                children: [
                  Text(
                    "MATE8",
                    style: TextStyle(
                        fontFamily: "Oswald",
                        color: Colors.white,
                        fontSize: 40),
                  ),
                  Text(
                    "Für die Studenten der Hochschule Fulda",
                    style: TextStyle(
                        fontFamily: "Oswald",
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Test");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Components.CreateInputField(
                          "Email", _emailController),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Components.CreatePasswordInputField(
                        "Email", "HS-Fulda@de", _passwordController),
                  ),
                  GestureDetector(
                      onTap: () => signIn(),
                      child: Components.GetButton("Einloggen")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Noch kein Account? ",
                            style: TextStyle(color: Colors.grey)),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUpScreen(),
                                  ),
                                ),
                            child: Text("jetzt Registrieren",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)))
                      ],
                    ),
                  )
                ],
              ),
            )),
          )
        ],
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
