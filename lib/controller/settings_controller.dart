import 'package:Mate8/controller/language_controller.dart';
import 'package:Mate8/screens/onboarding_screen.dart';
import 'package:Mate8/styles/static_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_picker/languages.dart';
import '../components/components.dart' as components;

class SettingsController extends GetxController {
  final generalTextEditingController = TextEditingController();
  final scrollController = FixedExtentScrollController();
  final supportedLocales =
      Get.find<LanguageController>().supportedLocales.toList(growable: false);
  var _selectedLanguageIndex = 0;
  var _passwordChangeErrorText = ''.obs;

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(const OnboardingScreen());
      Get.deleteAll();
    } catch (e) {
      print(e);
    }
  }

  void onSelectedLanguageChanged(index) {
    _selectedLanguageIndex = index;
  }

  void changeLanguage() async {
    var supportedLanguages = getSupportedCountriesText();
    await components.showBottomSheet(
        title: 'Sprache wählen',
        child: components.BottomSheetPicker(
            items: supportedLanguages,
            controller: scrollController,
            onSelectedItemChanged: onSelectedLanguageChanged));

    Get.updateLocale(supportedLocales[_selectedLanguageIndex]);
  }

  void showChangePasswordDialog() async {
    generalTextEditingController.text = '';
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(15),
        title: 'neues Passwort',
        content: Column(
          children: [
            components.CustomTextFormField(
              'Passwort eingeben',
              controller: generalTextEditingController,
            ),
            const SizedBox(
              height: 5,
            ),
            components.CustomButton(
              'Bestätigen',
              fontColor: StaticColors.secondaryFontColor,
              onTap: changePassword,
            ),
            Obx(() => Text(
                  _passwordChangeErrorText.value,
                  style: const TextStyle(color: Colors.red),
                ))
          ],
        ));
  }

  void changePassword() async {
    try {
      await FirebaseAuth.instance.currentUser
          ?.updatePassword(generalTextEditingController.text);
    } catch (e) {
      _passwordChangeErrorText.value = e.toString();
    }
  }

  void changeUserVisibility() async {
    FirebaseAuth.instance.currentUser?.updatePassword('');
  }

  void deleteUser() async {
    FirebaseAuth.instance.currentUser?.delete();
  }

  void showAppInfo() async {
    Get.defaultDialog(
      title: 'App Info',
      content: Column(
        children: [
          const Text('Version: 1.0'),
          const Text('Created by: Patryk Stemporowski'),
          components.CustomButton(
            'Close',
            fontColor: Colors.white,
            onTap: closeDialog,
          )
        ],
      ),
    );
  }

  void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  List<String> getSupportedCountriesText() {
    return supportedLocales
        .map((locale) =>
            '${getFlagEmoji(locale.countryCode ?? '')} ${getLanguageName(locale)}')
        .toList();
  }

  String getLanguageName(Locale locale) {
    return Language.fromIsoCode(locale.languageCode).name;
  }

  String getFlagEmoji(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;
    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;
    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }
}
