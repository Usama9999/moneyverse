import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/models/chat_group_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'chat_room.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar('Chats', isCentered: true), body: chatList());
  }

  Column chatList() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .where('users', arrayContains: Get.find<UserDetail>().userId)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppViews.showLoading();
              }
              if (snapshot.data!.docs.isEmpty) {
                return noChatContainer();
              }
              return chats(snapshot);
            })
      ],
    );
  }

  Expanded chats(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot.data!.docs.length,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemBuilder: (BuildContext contextM, index) {
          ChatGroupModel chat =
              ChatGroupModel.fromMap(snapshot.data!.docs[index]);
          GroupChatUser user = chat.user1.id == Get.find<UserDetail>().userId
              ? chat.user2
              : chat.user1;
          return ChatListItem(user: user, chat: chat);
        },
      ),
    );
  }

  Expanded noChatContainer() {
    return Expanded(
        child: Center(
      child: AppViews.showGif(true, 'nodata', text: 'No Chats'),
    ));
  }
}

class ChatListItem extends StatefulWidget {
  const ChatListItem({
    super.key,
    required this.user,
    required this.chat,
  });

  final GroupChatUser user;
  final ChatGroupModel chat;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(
          10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: NetworkImageCustom(
                    image: widget.user.image,
                    fit: BoxFit.fill,
                    height: 34,
                    width: 34),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          widget.user.name,
                          style: subHeadingText(size: 16),
                        )),
                        Text(
                          timeago.format(widget.chat.timestamp.toDate(),
                              locale: 'en_short'),
                          style: lightText(size: 13),
                        ),

                        // readTimestamp(chat.timestamp)
                      ],
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.chat.lastMessage)),
                    ),
                    if (widget.chat.unreadCount != 0 &&
                        widget.chat.lastMessageBy !=
                            Get.find<UserDetail>().userId)
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.sparkblue,
                        child: Text(
                          widget.chat.unreadCount.toString(),
                          style: regularText(size: 12)
                              .copyWith(color: Colors.white),
                        ),
                      )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
      onTap: () {
        Get.to(() => ChatDetailScreen(
              roomId: widget.chat.roomId,
              userId: widget.user.id,
              image: widget.user.image,
              name: widget.user.name,
            ));
        if (widget.chat.unreadCount != 0 &&
            widget.chat.lastMessageBy != Get.find<UserDetail>().userId) {
          FirebaseFirestore.instance
              .collection('chats')
              .doc(widget.chat.roomId)
              .update({'unreadCount': 0});
        }
      },
    );
  }
}
