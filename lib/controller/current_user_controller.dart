import 'package:Mate8/screens/onboarding_screen.dart';
import 'package:Mate8/services/services.dart';
import 'package:get/get.dart';

import '../model/model.dart';

class CurrentUserController extends GetxController {
  var datastore = Get.find<Datastore>();

  User? currentUser;
  var isCurrentUserSet = false.obs;

  Future<bool> setUserDetails(String id) async {
    var user = await datastore.getUser(id);
    if (user == null) {
      isCurrentUserSet.value = false;
      Get.offAll(() => const OnboardingScreen());
      return false;
    } else {
      currentUser = user;
      isCurrentUserSet.value = true;
      return true;
    }
  }
}
