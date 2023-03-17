import 'dart:io';

import 'package:Mate8/components/components.dart';
import 'package:Mate8/controller/current_user_controller.dart';
import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/model/model.dart' as model;
import 'package:Mate8/screens/main_screen.dart';
import 'package:Mate8/services/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  var datastore = Get.find<Datastore>();
  var currentUserController = Get.find<CurrentUserController>();
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();
  var nameTextEditingController = TextEditingController();
  var nationalityTextEditingController = TextEditingController();
  var ageTextEditingController = TextEditingController();
  var descriptionTextEditingController = TextEditingController();
  var chipsTextEditingController = TextEditingController();
  var universityDepartmentTextEditingController = TextEditingController();
  var ages = List.generate(86, (index) => index + 15);
  var agesIndex = 5;
  var universityDepartments = model.getUniversityDepartments();
  var universityDepartmentIndex = 0;
  var singleWordsDescription = '';
  var file = File('').obs;
  var errorText = ''.obs;
  Country? selectedCountry;

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future onAgePickerTapped() async {
    Get.focusScope?.unfocus();
    await showBottomSheet(
        title: 'Alter auswählen',
        onClose: onAgePickerClosed,
        child: BottomSheetPicker(
          items: ages,
          controller: FixedExtentScrollController(initialItem: agesIndex),
          onSelectedItemChanged: onAgeSelected,
        ));
  }

  void onAgeSelected(index) async {
    agesIndex = index;
  }

  void onAgePickerClosed() async {
    ageTextEditingController.text = ages[agesIndex].toString();
  }

  void onUniversityDepartmentTapped() async {
    Get.focusScope?.unfocus();
    await showBottomSheet(
        title: 'Fachbereich wählen',
        onClose: onUniversityDepartmentPickerClosed,
        child: BottomSheetPicker(
          items: universityDepartments,
          controller: FixedExtentScrollController(
              initialItem: universityDepartmentIndex),
          onSelectedItemChanged: onUniversityDepartmentSelected,
        ));
  }

  void onUniversityDepartmentSelected(index) async {
    universityDepartmentIndex = index;
  }

  void onUniversityDepartmentPickerClosed() async {
    universityDepartmentTextEditingController.text =
        universityDepartments[universityDepartmentIndex].toString();
  }

  void onCountryPickerTapped(BuildContext context) async {
    Get.focusScope?.unfocus();
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        selectedCountry = country;
        nationalityTextEditingController.text = country.name;
      },
    );
  }

  void onDescriptionChipsSubmitted(String value) async =>
      singleWordsDescription = value;

  void pickImage() async {
    var imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    file.value = File(imagePicker?.path ?? '');
  }

  void setProfile() async {
    String? firestorePath;
    if (file.value.path.isNotEmpty) {
      //TODO Add Auth ID
      firestorePath = await datastore.uploadImage(
          file.value, FirebaseAuth.instance.currentUser?.uid ?? '');
    }

    if (firestorePath == null) return;

    var singleWords = singleWordsDescription.split(',');
    var user = model.User(
      age: ages[agesIndex],
      currentSemester: 0,
      name: nameTextEditingController.text,
      id: FirebaseAuth.instance.currentUser?.uid ?? '',
      profilePictureUrl: firestorePath,
      description: descriptionTextEditingController.text,
      shortUniversityDepartmentName:
          universityDepartments[universityDepartmentIndex].shortName,
      singleWordsDescription: singleWords,
      countryCode: selectedCountry?.countryCode,
    );
    try {
      await datastore.uploadUser(user: user);
    } catch (e) {
      Get.dialog(Text(e.toString()));
      return;
    }
    currentUserController.currentUser = user;
    Get.offAll(() => MainScreen());
    dispose();
  }

  bool validateInput(String name, String description, String singleWords) {
    if (name.isEmpty) {
      errorText.value = 'Name cannot be empty';
      return false;
    }
    if (description.isEmpty) {
      errorText.value = 'Description cannot be empty';
      return false;
    }
    if (singleWords.isEmpty) {
      errorText.value = 'Single words cannot be empty';
      return false;
    }
    if (singleWords.split(',').length > 10) {
      errorText.value = 'You can only enter up to 10 single words';
      return false;
    }
    // You can add more validation rules as necessary
    return true;
  }
}
