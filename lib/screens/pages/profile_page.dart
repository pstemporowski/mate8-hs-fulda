import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../background_screen.dart';
import '../components.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var halfScreenHeight = MediaQuery.of(context).size.height * 0.5;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      child: Column(
        children: [
          Stack(
            children: [
              BackgroundScreen(
                  src: "assets/images/profile.jpg", height: halfScreenHeight),
              Padding(
                padding: EdgeInsets.only(top: halfScreenHeight - 65, left: 10),
                child: Text(
                  "Annete",
                  style: TextStyle(
                      color: Colors.white, fontSize: 40, fontFamily: "Oswald"),
                ),
              )
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Studiengang: WI",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Alter: 25",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Beschreibung: Ich spiele grene Fußball und mach dies und das",
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Components.GetButton("Profil Bearbeiten"),
                    ),
                    GestureDetector(
                      onTap: () => FirebaseAuth.instance.signOut(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8, 0),
                        child: Components.GetButton("Abmelden"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Components.GetButton("Konto Löschen", Colors.red),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
