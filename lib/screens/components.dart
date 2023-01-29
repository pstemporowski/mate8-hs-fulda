import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:input_form_field/input_form_field.dart';

class Components {
  static Widget GetButton(String content, [Color color = Colors.green]) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Text(content,
              style: TextStyle(
                  color: Colors.white, fontSize: 17, fontFamily: "Oswald")),
        ),
      ),
    );
  }

  static Widget CreateInputField(
      String labelText, TextEditingController controller,
      {IconData iconData = Icons.mail,
      bool isNumeric = false,
      String? HintText}) {
    Icon prefixIcon = Icon(iconData, color: Colors.green);
    return InputFormField(
      textEditingController: controller,
      labelText: labelText,
      labelTextStyle: TextStyle(fontSize: 15, color: Colors.green),
      fillColor: Colors.white,
      hintText: HintText,
      borderColor: Colors.green,
      borderType: BorderType.outlined,
      prefix: prefixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      borderRadius: BorderRadius.circular(10),
      errorPadding: EdgeInsets.only(left: 10, top: 10),
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

  static Widget CreatePasswordInputField(
      String labelText, String hintText, TextEditingController controller) {
    return InputFormField(
      textEditingController: controller,
      labelText: "Passwort",
      hintText: "*****",
      obscuringCharacter: "*",
      labelTextStyle: TextStyle(fontSize: 15, color: Colors.green),
      fillColor: Colors.white,
      borderColor: Colors.green,
      prefix: const Icon(
        Icons.lock,
        color: Colors.green,
      ),
      borderType: BorderType.outlined,
      password: EnabledPassword(
        showPasswordIcon: const Icon(
          Icons.add,
          color: Colors.green,
        ),
        hidePasswordIcon: const Icon(
          Icons.visibility_off_sharp,
          color: Colors.green,
        ),
      ),
      bottomMargin: 10, // Optional
    );
  }
}
