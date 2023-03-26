import 'package:Mate8/styles/static_colors.dart';
import 'package:Mate8/styles/static_styles.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:blur/blur.dart';
import 'package:country_code/country_code.dart';
import 'package:country_flags/country_flags.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';
import 'package:badges/badges.dart' as badges;

import '../screens/main_pages/profile_page.dart';

part 'components.g.dart';

Future showBottomSheet(
    {required String title,
    String? textButtonValue,
    required Widget child,
    void Function()? onClose}) async {
  await Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoTextButton(
                    text: textButtonValue ?? 'Apply2'.tr,
                    color: Colors.blue,
                    style: const TextStyle(fontSize: 15),
                    onTap: Get.back,
                  ),
                ],
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      backgroundColor: StaticColors.secondaryColor);

  if (onClose != null) {
    onClose.call();
  }
}

@swidget
Widget customButton(String content,
    {Color? color, Color? fontColor, void Function()? onTap}) {
  return Material(
    elevation: 2.0,
    borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
    color: color ?? StaticColors.primaryColor,
    child: InkWell(
      borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: StaticColors.secondaryColor.withOpacity(0.3),
      onTapDown: (_) => HapticFeedback.lightImpact(),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(content.toUpperCase(),
              style: TextStyle(
                color: fontColor ?? StaticColors.primaryFontColor,
                fontSize: 14,
                fontFamily: "Oswald",
              )),
        ),
      ),
    ),
  );
}

@swidget
Widget bottomSheetPicker(
    {required List<dynamic> items,
    required FixedExtentScrollController controller,
    required void Function(int)? onSelectedItemChanged}) {
  return SizedBox(
      height: 200,
      child: CupertinoPicker.builder(
        magnification: 1.22,
        squeeze: 1.2,
        useMagnifier: true,
        itemExtent: 30,
        scrollController: controller,
// This is called when selected item is changed.
        onSelectedItemChanged: onSelectedItemChanged,
        childCount: items.length,
        itemBuilder: (context, index) {
          return _pickerText(items[index].toString());
        },
      ));
}

Widget _pickerText(String text) {
  return Center(
    child: Text(
      text,
      style: const TextStyle(fontSize: 17),
    ),
  );
}

@swidget
Widget customTextFormField(String labelText,
    {required TextEditingController controller,
      IconData iconData = Icons.mail,
      bool isNumeric = false,
      String? hintText,
      bool isMultiLine = false,
      TextInputType textInputType = TextInputType.text,
      bool? isEnabled,
      bool? isPassword}) {
  Icon prefixIcon = Icon(iconData, color: StaticColors.primaryColor);

  return TextFormField(
    enabled: isEnabled,
    controller: controller,
    minLines: isMultiLine ? 3 : null,
    maxLines: isMultiLine ? 7 : 1,
    obscureText: isPassword ?? false,
    keyboardType: isNumeric
        ? TextInputType.number
        : isMultiLine
        ? TextInputType.multiline
        : textInputType,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIcon: prefixIcon,
      filled: true,
      alignLabelWithHint: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(StaticStyles.borderRadiusForms),
          borderSide: const BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(StaticStyles.borderRadiusForms),
          borderSide: const BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid)),
      labelText: labelText,
      labelStyle: const TextStyle(
          fontSize: 15, color: StaticColors.primaryColor),
      fillColor: Colors.white,
      hintText: hintText,
    ),
    validator: (v) {
      if (isNumeric == true) {
        var number = num.tryParse(v ?? "");
        if (number == null) return "this needs be a number";
      }
      if (v != null && v.isEmpty) {
        return "Required";
      }
    },
  );
}

@swidget
Widget countryRow(String countryCode) {
  return RowSuper(
    innerDistance: 14,
    alignment: Alignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 0.5)),
        child: CountryFlags.flag(
          countryCode,
          height: 30,
          width: 40,
          borderRadius: 15,
        ),
      ),
      Text(
        CountryCode.tryParse(countryCode)?.alpha3 ?? '',
        style: const TextStyle(fontSize: 18),
      )
    ],
  );
}

@swidget
Widget profileInfoRow(
    {required String degreeProgram,
    String? age,
    required String semester,
    Color? color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      detailInfo(
          title: "DegreeProgram".tr, content: degreeProgram, color: color),
      detailInfo(title: "Age".tr, content: age ?? "", color: color),
      detailInfo(title: "Semester".tr, content: semester, color: color),
    ],
  );
}

@swidget
Widget singleProfileContent(
    {required String title,
    IconData? icon,
    required Widget content,
    Color? color}) {
  var titleText = Text(
    title,
    style: TextStyle(
        color: color ?? StaticColors.primaryFontColor,
        fontWeight: FontWeight.bold),
  );
  Widget titleWidget;

  if (icon == null) {
    titleWidget = titleText;
  } else {
    titleWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color ?? StaticColors.primaryFontColor),
        titleText
      ],
    );
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      titleWidget,
      content,
    ],
  );
}

@swidget
Widget wrappedInterestsTiles({required List<String> interests}) {
  var hobbiesTiles = <Widget>[];
  for (var element in interests) {
    hobbiesTiles.add(interestsTile(element));
  }
  return WrapSuper(
    lineSpacing: 4,
    spacing: 4,
    alignment: WrapSuperAlignment.center,
    children: hobbiesTiles,
  );
}

@swidget
Widget interestsTile(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
      border: Border.all(color: StaticColors.primaryColor),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        style: const TextStyle(color: StaticColors.primaryFontColor),
      ),
    ),
  );
}

@swidget
Widget columnSeparator(double width) => Center(
    child: Container(
        height: 1, width: width, color: Colors.grey.withOpacity(0.4)));

@swidget
Widget detailInfo(
    {required String title, required String content, Color? color}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: color ?? StaticColors.primaryFontColor),
        ),
        Text(
          content,
          style: TextStyle(color: color ?? StaticColors.primaryFontColor),
        ),
      ],
    ),
  );
}

String _formattedDate(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  bool isToday = DateTime.now().day == dateTime.day &&
      DateTime.now().month == dateTime.month &&
      DateTime.now().year == dateTime.year;
  if (isToday) {
    return DateFormat('HH:mm').format(dateTime);
  } else {
    return DateFormat('dd.MM HH:mm').format(dateTime);
  }
}

@swidget
Widget chatTile(
    {required Chat chat,
    required User chatUser,
    void Function()? onTap,
    String? tagId}) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Hero(
      tag: tagId ?? 'Tag',
      child: Material(
        borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
        color: Colors.white,
        child: InkWell(
          enableFeedback: true,
          borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
                color: Colors.transparent),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(StaticStyles.borderRadius),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(chatUser.profilePictureUrl),
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      chatUser.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Obx(
                          () =>
                      chat.messages.isEmpty
                          ? Container()
                          : Text(
                        chat.messages.first.text,
                        style: TextStyle(
                            fontSize: 14,
                            color: chat.isNewMessageAdded.value
                                ? Colors.black
                                : StaticColors.primaryFontColor
                                .withOpacity(0.5),
                            fontWeight: chat.isNewMessageAdded.value
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                          () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: badges.Badge(
                          showBadge: chat.isNewMessageAdded.value,
                          child: Text(
                            chat.messages.isEmpty
                                ? _formattedDate(chat.createdAt)
                                : _formattedDate(
                                    chat.messages.first.createdAt ??
                                        DateTime.now().millisecondsSinceEpoch),
                            style: TextStyle(
                                fontSize: 14,
                                color: chat.isNewMessageAdded.value
                                    ? StaticColors.primaryFontColor
                                    : StaticColors.primaryFontColor
                                        .withOpacity(0.5),
                                fontWeight: chat.isNewMessageAdded.value
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class SwipeCard extends StatelessWidget {
  final User candidate;
  final showProfileImage = false;

  const SwipeCard({
    Key? key,
    required this.candidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String tag = 'mainPage:${candidate.id}';
    return GestureDetector(
      onTap: () => onSwipeCardTapped(candidate),
      child: Hero(
        tag: tag,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.black.withOpacity(0.1),
                  spreadRadius: 7,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: FractionallySizedBox(
                      heightFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(candidate.profilePictureUrl),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(StaticStyles.borderRadius),
                            topRight:
                                Radius.circular(StaticStyles.borderRadius),
                          ),
                        ),
                      ).blurred(
                        blur: showProfileImage ? 0 : 25,
                        colorOpacity: showProfileImage ? 0 : 0.7,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(StaticStyles.borderRadius)),
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
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: StaticColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(StaticStyles.borderRadius),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: ColumnSuper(
                              innerDistance: 15,
                              children: [
                                buildNameTitle(),
                                const ColumnSeparator(double.infinity - 50),
                                ProfileInfoRow(
                                  degreeProgram:
                                  candidate.shortUniversityDepartmentName,
                                  semester:
                                  candidate.currentSemester.toString(),
                                  age: candidate.age.toString(),
                                  color: StaticColors.secondaryFontColor,
                                ),
                                const ColumnSeparator(double.infinity - 50),
                                SingleProfileContent(
                                  color: StaticColors.secondaryFontColor,
                                  title: 'Description'.tr,
                                  icon: Icons.description,
                                  content: Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      candidate.description,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: const TextStyle(
                                          color:
                                              StaticColors.secondaryFontColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSwipeCardTapped(User user) {
    Get.to(() => ProfilePage(
          user,
          tag: 'mainPage:${user.id}',
          showProfileImage: showProfileImage,
        ));
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
            color: StaticColors.secondaryColor,
          ),
          child: const Center(
            child: Icon(
              Icons.person,
              color: StaticColors.primaryColor,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          candidate.name,
          style: const TextStyle(
              color: StaticColors.secondaryFontColor,
              fontSize: 32,
              fontFamily: "Oswald",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title),
      centerTitle: true,
      shadowColor: Colors.transparent,
      backgroundColor: StaticColors.primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
