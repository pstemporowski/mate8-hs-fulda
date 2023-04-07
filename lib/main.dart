import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/controller/settings_controller.dart';
import 'package:Mate8/controller/sign_in_controller.dart';
import 'package:Mate8/controller/sign_up_controller.dart';
import 'package:Mate8/screens/onboarding_screen.dart';
import 'package:Mate8/screens/verify_screen.dart';
import 'package:Mate8/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controller/current_user_controller.dart';
import 'controller/language_controller.dart';
import 'controller/routing_controller.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() => Datastore(), fenix: true);
  Get.lazyPut(() => SignInController(), fenix: true);
  Get.lazyPut(() => SettingsController(), fenix: true);
  Get.lazyPut(() => LanguageController(), fenix: true);
  Get.lazyPut(() => MatchesController(), fenix: true);
  Get.lazyPut(() => CurrentUserController(), fenix: true);
  Get.lazyPut(() => RoutingController(), fenix: true);
  Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final languageController = Get.find<LanguageController>();
  final Stream<User?> _userStream = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      transitionDuration: const Duration(milliseconds: 800),
      supportedLocales: languageController.supportedLocales,
      fallbackLocale: languageController.supportedLocales[1],
      locale: Get.deviceLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: StreamBuilder<User?>(
        stream: _userStream,
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
            return const OnBoardingScreen();
          }
        },
      ),
    );
  }
}
