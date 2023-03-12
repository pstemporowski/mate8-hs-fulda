import 'package:Mate8/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

final datastore = Datastore();

class User {
  final String id;
  final String name;
  final int age;
  final String profilePicture;

  User(
      {required this.id,
      required this.name,
      required this.age,
      required this.profilePicture});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      profilePicture: data['profile_picture'] ?? '',
    );
  }
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

/*
  final String senderId;
  final String content;
  final int timestamp;

  Message({
    required this.senderId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['sender_id'],
      content: map['content'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'content': content,
      'timestamp': timestamp,
    };
  }

  @override
  types.Message copyWith({types.User? author, int? createdAt, String? id, Map<String, dynamic>? metadata, String? remoteId, types.Message? repliedMessage, String? roomId, bool? showStatus, types.Status? status, int? updatedAt}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
  
   */
