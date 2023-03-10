import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/chat_controller.dart';
import 'controller/language_controller.dart';
import 'controller/mainscreen_controller.dart';
import 'screens/email_screen.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Mate8",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() => MainScreenController());
  Get.lazyPut(() => MatchesController());
  Get.lazyPut(() => ChatController());
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        translations: Messages(),
        locale: const Locale('de', 'DE'),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return EmailScreen();
              } else {
                return MainScreen();
              }
            }));
  }
}
