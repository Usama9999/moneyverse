import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talentogram/controllers/chat_controllers/chat_detail_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/custom_bottom_option_sheet.dart';
import 'package:talentogram/models/chat_model.dart';
import 'package:talentogram/models/local_chat_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

import '../../globals/container_properties.dart';
import '../../globals/widgets/chat_list_item.dart';

class ChatDetailScreen extends StatefulWidget {
  final String roomId;
  final int userId;
  final String name;
  final String image;
  final bool supportRoom;
  const ChatDetailScreen({
    Key? key,
    required this.roomId,
    required this.userId,
    required this.image,
    required this.name,
    this.supportRoom = false,
  }) : super(key: key);

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  var controller = Get.put(ChatDetailController());

  late Stream<QuerySnapshot> stream;

  @override
  void initState() {
    controller.id = widget.roomId;
    controller.userId = widget.userId;
    stream = FirebaseFirestore.instance
        .collection(widget.supportRoom ? 'supportChats' : 'chats')
        .doc(widget.roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(child: messages(context)),
          ],
        )));
  }

  AppBar _appBar() {
    return customAppBar(
      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: widget.supportRoom
                ? Container()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: NetworkImageCustom(
                        image: widget.image,
                        fit: BoxFit.fill,
                        height: 34,
                        width: 34),
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.supportRoom ? 'Moneyverse Support' : widget.name,
                style: subHeadingText(size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack messages(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: stream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext contextM, index) {
                        ChatModel chatModel =
                            ChatModel.fromMap(snapshot.data!.docs[index]);
                        LocalChatModel chat = LocalChatModel(
                            time: chatModel.timeStamp,
                            message: chatModel.message,
                            files: chatModel.files,
                            mMsgType:
                                chatModel.from == Get.find<UserDetail>().userId
                                    ? MsgType.right
                                    : MsgType.left);

                        return ChatListItem(
                          mChatModel: chat,
                          onTap: () {},
                        );
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<ChatDetailController>(builder: (value) {
              return SizedBox(
                height: value.isShowEmojis ? 260 : 60,
              );
            })
          ],
        ),
        Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            _textField(context),
            _emojiSection()
          ],
        ),
      ],
    );
  }

  GetBuilder<ChatDetailController> _emojiSection() {
    return GetBuilder<ChatDetailController>(builder: (value) {
      return Visibility(
          visible: value.isShowEmojis,
          child: SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                Wrap(
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  spacing: 10,
                  children: List.generate(
                      value.emojis.length,
                      (index) => InkWell(
                            onTap: () {
                              value.addEmojis(value.emojis[index]);
                            },
                            child: Text(
                              value.emojis[index],
                              style: const TextStyle(fontSize: 27),
                            ),
                          )),
                )
              ],
            ),
          ));
    });
  }

  Column _textField(BuildContext context) {
    return Column(
      children: [
        GetBuilder<ChatDetailController>(builder: (value) {
          return Visibility(
            visible: value.loading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                color: AppColors.sparkliteblue3,
              ),
            ),
          );
        }),
        Container(
          height: ht(45),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.sparkblue,
              borderRadius: BorderRadius.circular(100)),
          child: TextField(
            onTap: () => controller.disableEmoji(),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            controller: controller.controllerMessage,
            textAlign: TextAlign.start,
            style: regularText(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              // fillColor: AppColors.primaryColor,
              prefixIconConstraints: const BoxConstraints(minWidth: 35),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Transform.rotate(
                        angle: -1,
                        child: Icon(
                          Icons.attachment,
                          color: AppColors.warning,
                        )),
                    onPressed: () {
                      controller.showImagePicker(context);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: GetBuilder<ChatDetailController>(builder: (value) {
                      return InkWell(
                        onTap: () {
                          controller.sendMessage();
                        },
                        child: SizedBox(
                          width: ht(45),
                          height: ht(45),
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.send,
                              color: AppColors.sparkblue,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              prefixIcon: InkWell(
                child: GetBuilder<ChatDetailController>(builder: (value) {
                  return Container(
                      margin: const EdgeInsets.only(left: 10, right: 20),
                      alignment: Alignment.center,
                      width: 30,
                      child: Icon(
                        !value.isShowEmojis
                            ? Icons.emoji_emotions
                            : Icons.keyboard,
                        color: AppColors.warning,
                      ));
                }),
                onTap: () {
                  controller.showEmoji();
                  FocusScope.of(context).unfocus();
                },
              ),
              contentPadding: const EdgeInsets.only(top: 7, left: 15),
              focusedBorder: AppViews.textFieldRoundBorder(),
              border: AppViews.textFieldRoundBorder(),
              disabledBorder: AppViews.textFieldRoundBorder(),
              focusedErrorBorder: AppViews.textFieldRoundBorder(),
              hintText: "Type your message...",
              hintStyle: regularText(color: AppColors.colorWhite),

              // filled: true,
            ),
          ),
          // color: Colors.red,
        ),
      ],
    );
  }
}
