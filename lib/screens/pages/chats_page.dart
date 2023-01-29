import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      child: SafeArea(
        child: Column(
          children: [
            Center(
                child: Text(
              "Chats",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
            Expanded(
              child: ListView(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
