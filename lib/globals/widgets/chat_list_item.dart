import 'package:flutter/material.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/models/local_chat_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class ChatListItem extends StatelessWidget {
  final LocalChatModel mChatModel;
  final Function onTap;

  const ChatListItem({Key? key, required this.mChatModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget mWidget = Container();
    switch (mChatModel.mMsgType) {
      case MsgType.left:
        mWidget = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(right: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mChatModel.message,
                            style: regularText(size: 16)
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  // Visibility(
                  //     visible: mChatModel.files.isNotEmpty ? true : false,
                  //     child: ImageCollapse(
                  //       appBarColor: AppColors.primaryColor,
                  //       imageUrls: mChatModel.files as List<String>,
                  //       fadingColorCollapse: AppColors.primaryColor,
                  //       titleGallery: "Chats",
                  //     )),
                ],
              ),
            )),
          ],
        );
        break;
      case MsgType.right:
        mWidget = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mChatModel.message,
                            style: regularText(size: 16)
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  // Visibility(
                  //     visible: mChatModel.files.isNotEmpty ? true : false,
                  //     child: ImageCollapse(
                  //       appBarColor: AppColors.primaryColor,
                  //       backgroundImageView: const BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(5)),
                  //       ),
                  //       imageUrls: mChatModel.files as List<String>,
                  //       fadingColorCollapse: AppColors.primaryColor,
                  //       titleGallery: "Chats",
                  //     )),
                ],
              ),
            )),
          ],
        );
        break;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      child: mWidget,
    );
  }
}
