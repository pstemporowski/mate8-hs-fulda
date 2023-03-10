import 'package:Mate8/styles/static_colors.dart';
import 'package:Mate8/styles/static_styles.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

part 'components.g.dart';

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
Widget customTextFormField(String labelText,
    {required TextEditingController controller,
    IconData iconData = Icons.mail,
    bool isNumeric = false,
    String? hintText,
    bool? isPassword}) {
  Icon prefixIcon = Icon(iconData, color: StaticColors.primaryColor);

  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIcon: prefixIcon,
      contentPadding: EdgeInsets.all(StaticStyles.borderRadiusForms),
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

/*
      borderColor: Colors.green,
      borderType: BorderType.outlined,
      prefix: prefixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      borderRadius: BorderRadius.circular(10),
      errorPadding: EdgeInsets.only(left: 10, top: 10),

 */
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
      Text(
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
