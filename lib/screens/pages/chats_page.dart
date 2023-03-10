import 'package:Mate8/controller/matches_controller.dart';
import 'package:Mate8/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../styles/static_colors.dart';
import '../../styles/static_styles.dart';

class ChatsPage extends GetView<MatchesController> {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: StaticColors.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.chats.length,
                    itemBuilder: (_, index) {
                      var chat = controller.chats[index];
                      var chatUser = chat.otherUser;
                      var time = DateTime(chat.timestamp).obs;
                      var now = DateTime.now();
                      final chatScreen = ChatScreen(
                        currentUser: const types.User(
                            id: '4cceb2b6-0955-4960-b67b-309ff1766b27'),
                        otherUser: types.User(
                            id: chatUser.id,
                            firstName: chatUser.name,
                            imageUrl: chatUser.profilePicture),
                        textMessages: chat.messages,
                      );
                      print(chat.messages.value.length);
                      return GestureDetector(
                        onTap: () => Get.to(chatScreen),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        StaticStyles.borderRadius),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(chatUser.profilePicture),
                                    )),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    chatUser.name,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Obx(
                                    () => chat.messages.isEmpty
                                        ? Text(
                                            'Noch keine Nachricht',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: StaticColors
                                                    .primaryFontColor
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            chat.messages.last.text,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: StaticColors
                                                    .primaryFontColor
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.bold),
                                          ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Obx(
                                    () => Text(
                                      time.value.year == now.year &&
                                              time.value.month == now.month &&
                                              time.value.day == now.day
                                          ? DateFormat('HH:mm')
                                              .format(time.value)
                                          : DateFormat('dd.MM HH:mm')
                                              .format(time.value),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: StaticColors.primaryFontColor
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
