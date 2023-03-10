import 'package:Mate8/styles/static_colors.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:country_flags/country_flags.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/static_styles.dart';
import '../background_screen.dart';
import '../../components/components.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var halfScreenHeight = screenHeight * 0.5;
    final double maxHeight = screenHeight * 0.5;
    final double minHeight = screenHeight * 0.1;
    var hobbies = [
      'Fußball',
      'Tennis',
      'Baseball',
      'Football',
      'Lernen',
      'Programmieren',
      'Ficken',
      'Ficken',
      'Ficken',
      'Ficken',
      'Ficken',
      'Ficken',
      'Ficken',
      'Ficken'
    ];
    var scrollController = ScrollController();
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: maxHeight,
            flexibleSpace: Stack(children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(StaticStyles.borderRadius)),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/profile.jpg', // replace with your image path
                        ),
                      )),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(StaticStyles.borderRadius)),
                ),
              )
            ]),
            floating: false,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                    padding: const EdgeInsets.all(16.0),
                    child: ColumnSuper(
                      innerDistance: 30,
                      children: [
                        buildNameTitle(),
                        ColumnSeparator(screenWidth - 50),
                        const ProfileInfoRow(
                            degreeProgram: "WI", semester: "5", age: "21"),
                        ColumnSeparator(screenWidth - 50),
                        SingleProfileContent(
                            title: "Nationality".tr,
                            icon: FluentIcons.flag_28_regular,
                            content: const CountryRow()),
                        SingleProfileContent(
                          title: "Interests".tr,
                          icon: Icons.beach_access_outlined,
                          content: WrappedInterestsTiles(interests: hobbies),
                        ),
                        SingleProfileContent(
                          title: 'Description'.tr,
                          icon: Icons.description,
                          content: Text(
                            "Ich spiele grene Fußball und mach dies und das",
                            style:
                                TextStyle(color: StaticColors.primaryFontColor),
                          ),
                        ),
                        getSettingsPanel(true)
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildNameTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
            color: StaticColors.primaryColor,
          ),
          child: const Center(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          "Annette Mumber",
          style: TextStyle(
              color: StaticColors.primaryFontColor,
              fontSize: 32,
              fontFamily: "Oswald",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget? getSettingsPanel(bool isUser) {
    if (isUser) {
      /*
      return SingleProfileContent(
        title: "ProfileSetting".tr,
        content: ColumnSuper(
          alignment: Alignment.center,
          innerDistance: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Components.customButton("Edit".tr,
                        color: Colors.purple)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Components.customButton("SignOut".tr,
                        color: Colors.red)),
              ],
            ),
          ],
        ),
      );

       */
    }

    return null;
  }
}
