import 'package:Mate8/styles/static_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen(
      {Key? key, this.src = 'assets/images/background.png', this.height = 300})
      : super(key: key);

  final double height;
  final String src;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: height,
        child: Column(
          children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(src)),
                ),
                height: height,
              ),
            ])
          ],
        ));
  }
}
