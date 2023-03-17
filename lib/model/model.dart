import 'package:Mate8/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

final datastore = Datastore();

class User {
  final String shortUniversityDepartmentName;
  final List<String> singleWordsDescription;
  final String id;
  final String name;
  final int age;
  final String profilePictureUrl;
  final String description;
  final String? countryCode;
  final int currentSemester; // new property for current semester

  User({
    required this.shortUniversityDepartmentName,
    required this.singleWordsDescription,
    required this.id,
    required this.name,
    required this.age,
    required this.profilePictureUrl,
    required this.description,
    this.countryCode,
    required this.currentSemester, // initialize new property
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      profilePictureUrl: data['profile_picture_url'] ?? '',
      shortUniversityDepartmentName:
          data['short_university_department_name'] ?? '',
      singleWordsDescription:
          List<String>.from(data['single_words_description'] ?? []),
      countryCode: data['country_code'],
      description: data['description'] ?? '',
      currentSemester:
          data['current_semester'] ?? 0, // get value of new property
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'age': age,
        'short_university_department_name': shortUniversityDepartmentName,
        'single_words_description':
            FieldValue.arrayUnion(singleWordsDescription),
        'country_code': countryCode,
        'description': description,
        'profile_picture_url': profilePictureUrl,
        'current_semester': currentSemester, // add value of new property
      };
}

class UserActionForCurrentUser {
  final bool isMatch;
  final String otherUserId;

  UserActionForCurrentUser({required this.otherUserId, required this.isMatch});

  factory UserActionForCurrentUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserActionForCurrentUser(
      otherUserId: doc.id,
      isMatch: data['isMatch'],
    );
  }
}

class FirebaseAuthClass {
  static FirebaseAuth auth = FirebaseAuth.instance;
}

class Chat {
  final String id;
  var isNewMessageAdded = false.obs;
  final User otherUser;
  final int createdAt;
  final RxList<types.TextMessage> messages;

  CollectionReference get messagesRef =>
      FirebaseFirestore.instance.collection('chats/$id/messages');

  Chat({
    required this.id,
    required this.otherUser,
    required this.createdAt,
    required this.messages,
  });

  factory Chat.fromFirestore(DocumentSnapshot doc, User otherUser) {
    Map<String, dynamic>? data = doc.data()! as Map<String, dynamic>;
    var messages = RxList<types.TextMessage>();
    var timestamp = data?['timestamp'] as int ?? 0;

    return Chat(
      id: doc.id,
      otherUser: otherUser,
      createdAt: timestamp,
      messages: messages,
    );
  }
}

class UniversityDepartment {
  final String shortName;
  final String longName;

  UniversityDepartment({required this.shortName, required this.longName});

  @override
  toString() {
    return longName;
  }
}

List<UniversityDepartment> getUniversityDepartments() {
  return [
    UniversityDepartment(
      shortName: 'AI',
      longName: 'Angewandte Informatik',
    ),
    UniversityDepartment(
      shortName: 'EEIT',
      longName: 'Elektrotechnik und Informationstechnik',
    ),
    UniversityDepartment(
      shortName: 'LT',
      longName: 'Lebensmitteltechnologie',
    ),
    UniversityDepartment(
      shortName: 'OT',
      longName: 'Oecotrophologie',
    ),
    UniversityDepartment(
      shortName: 'GW',
      longName: 'Gesundheitswissenschaften',
    ),
    UniversityDepartment(
      shortName: 'SKW',
      longName: 'Sozial- und Kulturwissenschaften',
    ),
    UniversityDepartment(
      shortName: 'SW',
      longName: 'Sozialwesen',
    ),
    UniversityDepartment(
      shortName: 'WI',
      longName: 'Wirtschaft',
    ),
  ];
}
