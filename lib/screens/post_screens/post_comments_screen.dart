import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/post_comment_controller.dart';
import 'package:talentogram/controllers/post_controller.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/custom_bottom_option_sheet.dart';
import 'package:talentogram/models/post_comments.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

class PostCommentScreen extends StatefulWidget {
  final int postId;
  final int toUser;
  const PostCommentScreen(
      {super.key, required this.postId, required this.toUser});

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  var controller = Get.put(PostCommentController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.getPostComments(widget.postId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: GetBuilder<PostCommentController>(builder: (value) {
        return Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            backArrowAppBar('Comments', isCentered: true),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          child: value.mShowData
                              ? Center(
                                  child: AppViews.showLoading(),
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  separatorBuilder: ((context, index) =>
                                      const SizedBox(
                                        height: 20,
                                      )),
                                  itemCount: value.comments.length,
                                  itemBuilder: ((context, index) {
                                    return _commentWidget(
                                        value.comments[index]);
                                  }))),
                      SizedBox(
                        height: value.isShowEmojis ? 260 : 60,
                      )
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
              ),
            ),
          ],
        );
      })),
    );
  }

  InkWell _commentWidget(PostComments comment) {
    return InkWell(
      onTap: () {
        // Get.to(() => ExploreProfileScreen(userId: comment.userId));
      },
      onLongPress: () {
        if (comment.userId.toString() == Get.find<UserDetail>().userId) {
          customBottomSheet(context, ['Delete'], 0, (val) {
            if (val == 0) {
              Get.find<PostController>()
                  .deleteComment(comment.commentId, comment.postId)
                  .then((value) {
                controller.deleteComment(comment);
              });
            }
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 1.5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: NetworkImageCustom(
                image: comment.image,
                height: 30,
                width: 30,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${comment.firstname} ${comment.lastname == comment.firstname ? "" : comment.lastname}',
                  style: subHeadingText(size: 14),
                ),
                Text(
                  comment.comment,
                  style: regularText(size: 14),
                ),
                Text(
                  comment.createdAt.split('T')[0],
                  style: regularText(size: 10).copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GetBuilder<PostCommentController> _emojiSection() {
    return GetBuilder<PostCommentController>(builder: (value) {
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
                              setState(() {});
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
          cursorColor: AppColors.primaryColor,
          onTap: () => controller.disableEmoji(),
          onChanged: (String strvalue) => controller.changeText(strvalue),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          controller: controller.controllerMessage,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints(minWidth: 35),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 12),
              alignment: Alignment.center,
              width: 50,
              child: GetBuilder<PostCommentController>(builder: (value) {
                return value.showSendButton && !value.sendLoader
                    ? InkWell(
                        onTap: () {
                          value.commentPost(widget.postId, widget.toUser);
                        },
                        child: Text(
                          'Post',
                          style: headingText(size: 15),
                        ),
                      )
                    : SizedBox(
                        child: Text(
                        'Post',
                        style: headingText(size: 15).copyWith(
                            color: AppColors.primaryColor.withOpacity(0.4)),
                      ));
              }),
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
            hintText: 'write a comment...',
            filled: true,
            fillColor: AppColors.colorWhite,
          ),
        ),
      ),
      // color: Colors.red,
    );
  }
}
