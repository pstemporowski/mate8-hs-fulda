import 'package:Mate8/styles/static_colors.dart';
import 'package:Mate8/styles/static_styles.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:country_flags/country_flags.dart';
import 'package:cupertino_text_button/cupertino_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';
import 'package:badges/badges.dart' as badges;

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
                    text: textButtonValue ?? 'Anwenden',
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
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(StaticStyles.borderRadius),
          color: color ?? StaticColors.primaryColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
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
            : TextInputType.name,
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
      labelStyle: TextStyle(fontSize: 15, color: StaticColors.primaryColor),
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
Widget countryRow() {
  return RowSuper(
    innerDistance: 14,
    alignment: Alignment.center,
    children: [
      CountryFlags.flag(
        'pl',
        height: 35,
        width: 35,
        borderRadius: 15,
      ),
      const Text(
        "Poland",
        style: TextStyle(fontSize: 18),
      )
    ],
  );
}

@swidget
Widget profileInfoRow(
    {required String degreeProgram, String? age, required String semester}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      detailInfo(title: "DegreeProgram".tr, content: degreeProgram),
      detailInfo(title: "Age".tr, content: age ?? ""),
      detailInfo(title: "Semester".tr, content: semester),
    ],
  );
}

@swidget
Widget singleProfileContent(
    {required String title, IconData? icon, required Widget content}) {
  var titleText = Text(
    title,
    style: TextStyle(
        color: StaticColors.primaryFontColor, fontWeight: FontWeight.bold),
  );
  Widget titleWidget;

  if (icon == null) {
    titleWidget = titleText;
  } else {
    titleWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(icon), titleText],
    );
  }
  return Column(
    children: [titleWidget, content],
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
        style: TextStyle(color: StaticColors.primaryFontColor),
      ),
    ),
  );
}

@swidget
Widget columnSeparator(double width) => Center(
    child: Container(
        height: 1, width: width, color: Colors.grey.withOpacity(0.4)));

@swidget
Widget detailInfo({required String title, required String content}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: StaticColors.primaryFontColor),
        ),
        Text(
          content,
          style: TextStyle(color: StaticColors.primaryFontColor),
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
      tag: chat.id,
      child: Material(
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
                        image: NetworkImage(chatUser.profilePictureUrl ?? ''),
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
                      () => chat.messages.isEmpty
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

  const SwipeCard({
    Key? key,
    required this.candidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            spreadRadius: 15,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/background.png',
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      candidate.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      candidate.age.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
