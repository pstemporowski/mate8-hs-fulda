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
      Get.offAll(const OnBoardingScreen());
      Get.deleteAll();
    } catch (e) {
      print(e);
    }
  }

  void onSelectedLanguageChanged(index) {
    _selectedLanguageIndex = index;
  }

  void changeLanguage() async {
    print('im in');
    var supportedLanguages = getSupportedCountriesText();
    print('test' + supportedLanguages.length.toString());
    await components.showBottomSheet(
        title: 'ChooseLanguage'.tr,
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
        title: 'NewPassword'.tr,
        content: Column(
          children: [
            components.CustomTextFormField(
              'InputPassword'.tr,
              controller: generalTextEditingController,
            ),
            const SizedBox(
              height: 5,
            ),
            components.CustomButton(
              'Apply'.tr,
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
      title: 'AppInfo'.tr,
      content: Column(
        children: [
          Text('VersionInfo'.tr),
          Text('CreatedBy'.tr),
          components.CustomButton(
            'Close'.tr,
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
    print(supportedLocales.length);
    return supportedLocales.map((locale) {
      return '${getFlagEmoji(locale.countryCode ?? '')} ${getLanguageName(locale)}';
    }).toList();
  }

  String getLanguageName(Locale locale) {
    try {
      print(locale.languageCode);
      if (locale.languageCode == 'zh') return 'Chinese';

      var name = Language.fromIsoCode(locale.languageCode).name;
      return name;
    } catch (e) {
      print('Error in locale: $locale'); // log the error
      return ''; // return an empty string or a default value
    }
  }

  String getFlagEmoji(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;
    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;
    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }
}
