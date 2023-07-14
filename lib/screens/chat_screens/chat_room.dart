import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/chat_controllers/chat_detail_controller.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/models/chat_model.dart';
import 'package:talentogram/models/local_chat_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/chat_list_item.dart';

class ChatDetailScreen extends StatefulWidget {
  final String roomId;
  final int userId;
  const ChatDetailScreen({Key? key, required this.roomId, required this.userId})
      : super(key: key);

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  var controller = Get.put(ChatDetailController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.roomId)
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
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
                            mMsgType: chatModel.from.toString() ==
                                    Get.find<UserDetail>().userId
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

        // AppViews.showLoadingWithStatus(isShowLoader)
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
                  alignment: WrapAlignment.start,
                  children: List.generate(
                      value.emojis.length,
                      (index) => InkWell(
                            onTap: () {
                              value.addEmojis(value.emojis[index]);
                            },
                            child: Text(
                              value.emojis[index],
                              style: const TextStyle(fontSize: 30),
                            ),
                          )),
                )
              ],
            ),
          ));
    });
  }

  Container _textField(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: Colors.grey.withOpacity(0.4),
          width: 0.9,
        ),
      )),
      child: SizedBox(
        height: 50,
        child: TextField(
          onTap: () => controller.disableEmoji(),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          controller: controller.controllerMessage,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints(minWidth: 35),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 12),
              alignment: Alignment.center,
              width: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GetBuilder<ChatDetailController>(builder: (value) {
                    return InkWell(
                      onTap: () {
                        controller.sendMessage(widget.roomId, widget.userId);
                      },
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.send,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            prefixIcon: InkWell(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                width: 30,
                child: Image.asset(
                  'assets/images/ic_smile.png',
                  height: 35,
                ),
              ),
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
            hintText: Constants.TXT_WRITE_A_MESSAGE,
            filled: true,
            fillColor: AppColors.colorWhite,
          ),
        ),
      ),
      // color: Colors.red,
    );
  }
}
