import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Datastore {
  final CollectionReference chatsRef =
      FirebaseFirestore.instance.collection('chats');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference userActionsRef =
  FirebaseFirestore.instance.collection('user_actions');
  var testGuid = '40f781d5-182d-4091-b11b-bff30cd51b8';

  Future<User?> getUser(String userId) async {
    var userSnap = await usersRef.doc(userId).get();

    if (userSnap.exists) {
      return User.fromFirestore(userSnap);
    }

    return null;
  }

  Future<List<User>> getUsers() async {
    QuerySnapshot querySnapshot = await usersRef.get();
    return querySnapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  Future<List<UserActionForCurrentUser>> getInteractedUsers(
      String currentUserId) async {
    var currentUserDoc =
        await usersRef.doc(currentUserId).collection('user_actions').get();
    var list = currentUserDoc.docs
        .map((doc) => UserActionForCurrentUser.fromFirestore(doc))
        .toList();
    print(list.length);
    return list;
  }

  Future<List<User>> getCandidateUsers(String currentUserID) async {
    var allUsers = await getUsers();
    var interactedUsers = await getInteractedUsers(currentUserID);

    return allUsers.where((user) {
      var userActions = interactedUsers
          .where((action) => action.otherUserId == user.id)
          .toList();
      return userActions.isEmpty;
    }).toList();
  }

  Future uploadUserAction({required String currentUserId,
    required String otherUserId,
    required bool isMatch}) async {
    try {
      DocumentReference currentUserActionRef = usersRef
          .doc(currentUserId)
          .collection('user_actions')
          .doc(otherUserId);

      DocumentSnapshot currentUserActionDoc = await currentUserActionRef.get();
      if (currentUserActionDoc.exists) {
        return;
      }

      await currentUserActionRef.set({
        'isMatch': isMatch,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      if (isMatch) {}
      checkMatch(userId: currentUserId, otherUserId: otherUserId);
    } catch (e) {
      print('Error uploading user action: $e');
    }
  }

  Future<void> checkMatch({required String userId, required String otherUserId}) async {
    DocumentSnapshot otherUserActionsDoc = await usersRef
        .doc(otherUserId)
        .collection('user_actions')
        .doc(userId)
        .get();
    if (otherUserActionsDoc.exists) {
      bool otherUserIsMatch = otherUserActionsDoc.get('isMatch');
      print(otherUserIsMatch);
      if (otherUserIsMatch == true) {
        await uploadChat(userId, otherUserId);
      }
    }
  }

  Future<void> uploadChat(String currentUserId, String otherUserId) async {
    CollectionReference chatsRef =
        FirebaseFirestore.instance.collection('chats');
    DocumentReference chatDocRef = chatsRef.doc();

    await chatDocRef.set({
      'users': [currentUserId, otherUserId],
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> uploadMessage(String chatId, types.TextMessage message) async {
    // Reference to the `messages` collection in Firestore under the specified chatId
    final messagesRef = chatsRef.doc(chatId).collection('messages');

    try {
      await messagesRef.add({
        'created_at': message.createdAt,
        'text': message.text,
        'sender_id': message.author.id,
      });
    } catch (e) {
      print('Error uploading message: $e');
    }
  }

  Future<List<Chat>> getChats(String userId) async {
    QuerySnapshot chatSnap =
        await chatsRef.where('users', arrayContains: userId).get();

    List<Chat> chats = [];
    for (var chatDoc in chatSnap.docs) {
      // Get the other user id from the chat document
      var data = chatDoc.data() as Map<String, dynamic>;
      List<dynamic> chatUsers = data['users'];
      String otherUserId = chatUsers.firstWhere((uid) => uid != userId);

      var otherUser = await getUser(otherUserId);

      if (otherUser == null) {
        continue;
      }

      Chat chat = Chat.fromFirestore(chatDoc, otherUser);
      chats.add(chat);
    }

    return chats;
  }

  Future<void> listenToChats(String currentUserId,
      {required Function(Chat) onNewChat,
      required Function(types.TextMessage, Chat) onNewMessage,
      Function()? onAllDataLoaded}) async {
    Stream<QuerySnapshot> chatsStream = chatsRef.snapshots();
    chatsStream.listen((QuerySnapshot snapshot) async {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          var data = change.doc.data();

          if (data != null) {
            Map<String, dynamic> chatData = data as Map<String, dynamic>;
            List<dynamic> chatUsers = chatData['users'];

            if (chatUsers.contains(currentUserId)) {
              var otherUserId = chatUsers.firstWhere(
                      (userId) => userId != currentUserId,
                  orElse: () => null);

              if (otherUserId == null) {
                continue;
              }

              var otherUser = await getUser(otherUserId);

              if (otherUser == null) {
                continue;
              }

              Chat chat = Chat.fromFirestore(change.doc, otherUser);
              listenToChatMessages(chat,
                  onNewMessage: (message, chat) => onNewMessage(message, chat));
              onNewChat(chat);
            }
          }
        }
      }
    });
  }

  types.TextMessage messageFromFirestore(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    final createdAt = data['created_at'];
    final text = data['text'] as String;
    final senderId = data['sender_id'] as String;
    return types.TextMessage(
      id: id,
      createdAt: createdAt,
      text: text,
      author: types.User(id: senderId),
    );
  }

  void listenToChatMessages(Chat chat,
      {Function(types.TextMessage, Chat)? onNewMessage}) async {
    Stream<QuerySnapshot> messagesStream =
        chat.messagesRef.orderBy('created_at', descending: false).snapshots();
    StreamSubscription<QuerySnapshot>? messagesSubscription;

    messagesSubscription = messagesStream.listen((QuerySnapshot snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          var data = change.doc.data();

          if (data == null) {
            continue;
          }

          var message = messageFromFirestore(change.doc);
          chat.messages.insert(0, message);
          if (onNewMessage != null) {
            onNewMessage(message, chat);
          }
        }
      }
    });
  }
}
