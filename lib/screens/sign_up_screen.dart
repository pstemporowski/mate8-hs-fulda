import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'background_screen.dart';
import 'components.dart';

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
                        "Email", "*****", _passwordController),
                  ),
                  GestureDetector(
                      onTap: () => signUp(context),
                      child: Components.GetButton("Registrieren")),
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
  }

  Future signUp(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
