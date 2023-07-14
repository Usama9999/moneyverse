import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/models/chat_group_model.dart';
import 'package:talentogram/screens/chat_screens/chat_room.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Widget widgetM = ListView(
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
                return const SizedBox();
              }

              return mesga(snapshot);
            })
      ],
    );

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 140,
            decoration: BoxDecoration(
                color: AppColors.orangeColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
            child: backArrowAppBar('Messages',
                isCentered: true, textColor: Colors.white),
          ),
          Expanded(child: widgetM),
        ],
      ),
    ));
  }

  ListView mesga(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data!.docs.length,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: AppColors.borderColor,
        );
      },
      itemBuilder: (BuildContext contextM, index) {
        ChatGroupModel chat =
            ChatGroupModel.fromMap(snapshot.data!.docs[index]);
        GroupChatUser user =
            chat.user1.id.toString() == Get.find<UserDetail>().userId
                ? chat.user2
                : chat.user1;
        // EstimatesModel mEstimatesModel = alEstimates[index];
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
                        image: user.image,
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
                              user.name,
                              style: subHeadingText(size: 16),
                            )),
                            Text(
                              timeago.format(chat.timestamp.toDate(),
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
                              child: Text(chat.lastMessage)),
                        ),
                        // CircleAvatar(
                        //   radius: 8,
                        //   backgroundColor:
                        //       AppColors.primaryColor,
                        //   child: Text(
                        //     '2',
                        //     style: regularText(size: 12)
                        //         .copyWith(
                        //             color: Colors.white),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
          onTap: () {
            Get.to(() => ChatDetailScreen(
                  roomId: snapshot.data!.docs[index].id,
                  userId: user.id,
                ));
          },
        );
      },
    );
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }
}
