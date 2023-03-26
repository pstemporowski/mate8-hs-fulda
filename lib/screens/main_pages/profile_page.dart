import 'package:Mate8/controller/current_user_controller.dart';
import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/styles/static_colors.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:country_flags/country_flags.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/model.dart';
import '../../styles/static_styles.dart';
import '../../components/components.dart';
import 'package:blur/blur.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(this.user,
      {super.key,
      this.tag,
      required this.showProfileImage,
      this.showNavBar = false});

  final User user;
  final bool showProfileImage;
  final bool showNavBar;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var halfScreenHeight = screenHeight * 0.5;
    final double maxHeight = screenHeight * 0.5;

    var scrollController = ScrollController();
    return Hero(
      tag: tag ?? 'Hero',
      child: Material(
        color: Colors.white,
        child: Container(
          margin: showNavBar ? const Pad(bottom: 60) : null,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            backgroundColor: StaticColors.secondaryColor,
            body: Builder(builder: (context) {
              SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  systemNavigationBarIconBrightness: Brightness.dark,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent));
              return CustomScrollView(
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
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(
                                      StaticStyles.borderRadius)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  user.profilePictureUrl ??
                                      '', // replace with your image path
                                ),
                              )),
                        ).blurred(
                          blur: showProfileImage ? 0 : 25,
                          colorOpacity: showProfileImage ? 0 : 0.7,
                          borderRadius: const BorderRadius.vertical(
                              bottom:
                                  Radius.circular(StaticStyles.borderRadius)),
                          overlay: showProfileImage
                              ? null
                              : Center(
                                  child: Text('UnlockedImage'.tr,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black45,
                                          fontSize: 18,
                                          overflow: TextOverflow.fade)),
                                ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
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
                              ProfileInfoRow(
                                  degreeProgram:
                                      user.shortUniversityDepartmentName,
                                  semester: user.currentSemester.toString(),
                                  age: user.age.toString()),
                              ColumnSeparator(screenWidth - 50),
                              SingleProfileContent(
                                  title: "Nationality".tr,
                                  icon: FluentIcons.flag_28_regular,
                                  content:
                                      CountryRow(user.countryCode ?? 'US')),
                              SingleProfileContent(
                                title: "Interests".tr,
                                icon: Icons.beach_access_outlined,
                                content: WrappedInterestsTiles(
                                    interests: user.singleWordsDescription),
                              ),
                              SingleProfileContent(
                                title: 'Description'.tr,
                                icon: Icons.description,
                                content: Text(
                                  user.description,
                                  style: const TextStyle(
                                      color: StaticColors.primaryFontColor),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
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
          user.name,
          style: const TextStyle(
              color: StaticColors.primaryFontColor,
              fontSize: 32,
              fontFamily: "Oswald",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
