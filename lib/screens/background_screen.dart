import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  BackgroundScreen(
      {Key? key, this.src = 'assets/images/background.png', this.height = 300})
      : super(key: key);

  final double height;
  final String src;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: this.height,
        child: Column(
          children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(src)),
                ),
                height: this.height,
              ),
              Container(
                height: this.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.transparent.withOpacity(0.0),
                          CupertinoColors.darkBackgroundGray.withOpacity(0.3),
                          CupertinoColors.darkBackgroundGray,
                        ],
                        stops: [
                          0.0,
                          0.5,
                          1.0
                        ])),
              )
            ])
          ],
        ));
  }
}
