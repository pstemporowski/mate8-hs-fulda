import 'dart:io';
import 'package:Mate8/components/components.dart';
import 'package:Mate8/controller/current_user_controller.dart';
import 'package:Mate8/model/model.dart' as model;
import 'package:Mate8/screens/main_screen.dart';
import 'package:Mate8/services/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  final datastore = Get.find<Datastore>();
  final currentUserController = Get.find<CurrentUserController>();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final nationalityTextEditingController = TextEditingController();
  final ageTextEditingController = TextEditingController();
  final descriptionTextEditingController = TextEditingController();
  final chipsTextEditingController = TextEditingController();
  final semesterTextEditingController = TextEditingController();
  final universityDepartmentTextEditingController = TextEditingController();
  final ages = List.generate(86, (index) => index + 15);
  final semesters = List.generate(20, (index) => index);
  final universityDepartments = model.getUniversityDepartments();
  var agesIndex = 5;
  var semesterIndex = 5;
  var universityDepartmentIndex = 0;
  var singleWordsDescription = '';
  var errorText = ''.obs;
  var file = File('').obs;
  Country? selectedCountry;

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future onAgePickerTapped() async {
    Get.focusScope?.unfocus();
    await showBottomSheet(
        title: 'ChooseAge'.tr,
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
        title: 'SelectSubjectArea'.tr,
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

  Future onSemesterPickerTapped() async {
    Get.focusScope?.unfocus();
    await showBottomSheet(
        title: 'SelectSemester'.tr,
        onClose: onSemesterPickerClosed,
        child: BottomSheetPicker(
          items: semesters,
          controller: FixedExtentScrollController(initialItem: semesterIndex),
          onSelectedItemChanged: onSemesterSelected,
        ));
  }

  void onSemesterSelected(index) async {
    semesterIndex = index;
  }

  void onSemesterPickerClosed() async {
    semesterTextEditingController.text = semesters[semesterIndex].toString();
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
    var singleWords = singleWordsDescription
        .trim()
        .split(',')
        .where((s) => s.isNotEmpty)
        .toList();

    var user = model.User(
      age: ages[agesIndex],
      currentSemester: semesters[semesterIndex],
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
    if (singleWords.split(',').length < 5) {
      errorText.value = 'You can only enter up to 10 single words';
      return false;
    }
    // You can add more validation rules as necessary
    return true;
  }
}
