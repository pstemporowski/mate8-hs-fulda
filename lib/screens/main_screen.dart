import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/chats_page.dart';
import 'pages/match_page.dart';
import 'pages/profile_page.dart';
import 'pages/profile_set_up_page.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _activePage = 0;
  final List<Widget> _tabItems = [MatchPage(), ChatsPage(), ProfilePage()];
  final bool isDone = false;

  @override
  Widget build(BuildContext context) {
    if (isDone)
      return getContent();
    else {
      return Scaffold(
        body: SetUpPage(),
        backgroundColor: Colors.black,
      );
    }
  }

  Widget getContent() {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: CupertinoColors.darkBackgroundGray,
          color: Colors.green,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(Icons.chat, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _activePage = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _tabItems[_activePage]);
  }
}
