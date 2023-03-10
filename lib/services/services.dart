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

  Future<List<UserAction>> getInteractedUsers() async {
    QuerySnapshot querySnapshot =
        await userActionsRef.where('user_id', isEqualTo: '2412312321').get();
    return querySnapshot.docs
        .map((doc) => UserAction.fromFirestore(doc))
        .toList();
  }

  Future<List<User>> getCandidateUsers() async {
    var allUsers = await getUsers();
    var interactedUsers = await getInteractedUsers();

    return allUsers
        .where((user) => interactedUsers
            .any((userAction) => userAction.otherUserId != user.id))
        .toList();
  }

  Future uploadUserAction(
      {required String currentUserId,
      required String otherUserId,
      required bool isMatch}) async {
    try {
      DocumentReference currentUserActionRef = userActionsRef
          .doc(currentUserId)
          .collection('actions')
          .doc(otherUserId);

      DocumentSnapshot currentUserActionDoc = await currentUserActionRef.get();
      if (currentUserActionDoc.exists) {
        return;
      }

      await currentUserActionRef.set({
        'user_id': currentUserId,
        'other_user_id': otherUserId,
        'isMatch': isMatch,
        'timestamp': FieldValue.serverTimestamp(),
      });
      if (isMatch) {}
      checkMatch(userId: currentUserId, otherUserId: otherUserId);
    } catch (e) {
      print('Error uploading user action: $e');
    }
  }

  Future<void> checkMatch(
      {required String userId, required String otherUserId}) async {
    DocumentSnapshot otherUserActionDoc = await userActionsRef
        .doc(otherUserId)
        .collection('user_actions')
        .doc(userId)
        .get();
    if (otherUserActionDoc.exists) {
      bool otherUserActionType = otherUserActionDoc.get('isMatch');

      if (otherUserActionType == true) {
        await uploadChat(userId, otherUserId);
      }
    }
  }

  Future<void> uploadChat(String currentUserId, String otherUserId) async {
    CollectionReference chatsRef =
        FirebaseFirestore.instance.collection('chats');
    DocumentReference chatDocRef = chatsRef.doc();

    CollectionReference messagesRef = chatDocRef.collection('messages');

    await chatDocRef.set({
      'users': [currentUserId, otherUserId],
      'timestamp': FieldValue.serverTimestamp(),
    });

    await messagesRef.add({
      'senderId': currentUserId,
      'text': 'Hello, World!',
      'timestamp': FieldValue.serverTimestamp(),
    });
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
      required Function(types.TextMessage, Chat) onNewMessage}) async {
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
              listenToChatMessages(chat, onNewMessage: onNewMessage);
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
    final userId = data['sender_id'] as String;

    return types.TextMessage(
      id: id,
      createdAt: createdAt,
      text: text,
      author: types.User(id: userId),
    );
  }

  void listenToChatMessages(Chat chat,
      {Function(types.TextMessage, Chat)? onNewMessage}) {
    Stream<QuerySnapshot> messagesStream = chat.messagesRef.snapshots();

    messagesStream.listen((QuerySnapshot snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          var data = change.doc.data();

          if (data == null) {
            continue;
          }

          var message = messageFromFirestore(change.doc);
          chat.messages.add(message);
          if (onNewMessage != null) {
            onNewMessage!(message, chat);
          }
        }
      }
    });
  }
}
