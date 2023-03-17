import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/controller/sign_in_controller.dart';
import 'package:Mate8/controller/sign_up_controller.dart';
import 'package:Mate8/screens/main_screen.dart';
import 'package:Mate8/screens/onboarding_screen.dart';
import 'package:Mate8/screens/verify_screen.dart';
import 'package:Mate8/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controller/current_user_controller.dart';
import 'controller/language_controller.dart';
import 'controller/main_screen_controller.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Mate8",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() => CurrentUserController());
  Get.put(Datastore());
  Get.lazyPut(() => MainScreenController());
  Get.lazyPut(() => SignInController(), fenix: true);
  Get.put(MatchesController());
  Get.put(CurrentUserController());
  Get.put<SignUpController>(SignUpController());
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final datastore = Get.find<Datastore>();
  final matchesController = Get.find<MatchesController>();
  var isCurrentUserSet = false.obs;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarColor: Colors.white));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      translations: Messages(),
      transitionDuration: const Duration(milliseconds: 800),
      locale: const Locale('de', 'DE'),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error'.tr),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return const VerifyScreen();
          } else {
            return const OnboardingScreen();
          }
        },
      ),
    );
  }

  Widget initMainScreen(String id) {
    return Obx(() => isCurrentUserSet.value
        ? MainScreen()
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }
}
