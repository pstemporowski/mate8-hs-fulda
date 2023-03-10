import 'package:Mate8/styles/static_colors.dart';
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
                          StaticColors.primaryColor.withOpacity(0.2),
                          StaticColors.primaryColor.withOpacity(0.4),
                          StaticColors.primaryColor.withOpacity(1),
                        ],
                        stops: const [
                          0.0,
                          0.5,
                          0.8,
                          1.0
                        ])),
              )
            ])
          ],
        ));
  }
}
