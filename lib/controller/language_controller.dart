import 'dart:ui';

import 'package:get/get.dart';

class LanguageController {
  final supportedLocales = const <Locale>[
    Locale('en', 'US'),
    Locale('de', 'DE'),
    Locale('hi', 'IN'),
    Locale('uk', 'UA')
  ];
}

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'de_DE': {
          'Home': 'Home',
          'Chats': 'Nachrichten',
          'Profile': 'Profil',
          'Settings': 'Einstellungen',
          'ForStudents': 'Für die Studenten der Hochschule Fulda',
          'GettingStarted': 'Los Legen',
          'SignIn': 'Einloggen',
          'SignInNow': 'Jetzt Einloggen',
          'SignUp': 'Registrieren',
          'SignOut': 'Abmelden',
          'Abort': 'Abbrechen',
          'Error': 'Irgendwas ist falsch',
          'GoBack': 'Zurück',
          'Next': 'Weiter',
          'Email': 'Email',
          'DegreeProgram': 'Studiengang',
          'Age': 'Alter',
          'Semester': 'Semester',
          'Interests': 'Interessen',
          'Description': 'Beschreibung',
          'ProfileSetting': 'Profil Einstellungen',
          'Edit': 'Bearbeiten',
          'EmailVerifyTitle': 'Email Verifizieren!',
          'EmailVerifyContent':
          'Um die App nutzen zu können, müssen Sie sich verifizieren! Sie habe eine E-Mail mit einem Link erhalten',
          'AlreadyVerified': 'bereits Verifiziert',
          'Password': 'Passwort',
          'ExistingAccount': 'Berreits ein Account?',
          'Nationality': 'Nationalität',
          'Details': 'Details',
          'DescribeIn5Words': 'Beschreibe dich in mindestens 5 Wörtern',
          'ChipsInputLabel': 'Chips eintragen',
          'DescribeIn5WordsExample':
              "Schreibe deine Interessen, Hobbys oder deine Charaktereigenschaften. (Beispiel: Lustig, Basketball)",
        },
        'en_US': {
          'Home': 'Home',
          'Chats': 'Chats',
          'Profile': 'Profile',
          'Settings': 'Settings',
          'ForStudents': 'For the students of Fulda University',
          'GettingStarted': 'Getting Started',
          'SignIn': 'Sign In',
          'SignInNow': 'Sign In Now',
          'SignUp': 'Sign Up',
          'SignOut': 'Sign Out',
          'Abort': 'Abort',
          'Error': 'Something went wrong',
          'GoBack': 'Go Back',
          'Next': 'Next',
          'Email': 'Email',
          'DegreeProgram': 'Degree Program',
          'Age': 'Age',
          'Semester': 'Semester',
          'Interests': 'Interests',
          'Description': 'Description',
          'ProfileSetting': 'Profile Settings',
          'Edit': 'Edit',
          'EmailVerifyTitle': 'Verify Email!',
          'EmailVerifyContent':
              'To use the app, you need to verify your email! You have received an email with a verification link.',
          'AlreadyVerified': 'Already Verified',
          'Password': 'Password',
          'ExistingAccount': 'Already have an account?',
          'Nationality': 'Nationality',
          'Details': 'Details',
          'DescribeIn5Words': 'Describe yourself in at least 5 words',
          'ChipsInputLabel': 'Enter Chips',
          'DescribeIn5WordsExample':
              "Write your interests, hobbies or personality traits. (Example: Funny, Basketball)",
        },
        'hi_IN': {
          'Home': 'होम',
          'Chats': 'चैट',
          'Profile': 'प्रोफाइल',
          'Settings': 'सेटिंग्स',
          'ForStudents': 'फुलडा विश्वविद्यालय के छात्रों के लिए',
          'GettingStarted': 'शुरू हो जाओ',
          'SignIn': 'साइन इन करें',
          'SignInNow': 'अभी साइन इन करें',
          'SignUp': 'साइन अप करें',
          'SignOut': 'लॉग आउट करें',
          'Abort': 'रद्द करें',
          'Error': 'कुछ गलत हो गया है',
          'GoBack': 'वापस जाएं',
          'Next': 'अगला',
          'Email': 'ईमेल',
          'DegreeProgram': 'डिग्री प्रोग्राम',
          'Age': 'आयु',
          'Semester': 'सेमेस्टर',
          'Interests': 'इंटरेस्ट्स',
          'Description': 'विवरण',
          'ProfileSetting': 'प्रोफाइल सेटिंग',
          'Edit': 'संपादित करें',
          'EmailVerifyTitle': 'ईमेल सत्यापित करें!',
          'EmailVerifyContent':
              'ऐप का उपयोग करने के लिए, आपको सत्यापित करना होगा! आपको एक लिंक वाला ईमेल मिला होगा',
          'AlreadyVerified': 'पहले से सत्यापित',
          'Password': 'पासवर्ड',
          'ExistingAccount': 'पहले से ही एक खाता है?',
          'Nationality': 'राष्ट्रीयता',
          'Details': 'विवरण',
          'DescribeIn5Words': 'कम से कम 5 शब्दों में खुद का वर्णन करें',
          'ChipsInputLabel': 'चिप्स भरें',
          'DescribeIn5WordsExample':
              'अपने इंटरेस्ट, हॉबी या अपने चरित्र के विवरण लिखें। (उदाहरण: मजेदार, बास्केटब'
        }
      };
}
