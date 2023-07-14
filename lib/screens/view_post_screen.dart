import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/components/user_post.dart';
import 'package:talentogram/controllers/post_comment_controller.dart';
import 'package:talentogram/controllers/post_controller.dart';
import 'package:talentogram/controllers/view_post_controller.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/loader/three_bounce.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/models/post_comments.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';
import 'package:talentogram/globals/widgets/appbars.dart';

class ViewPostScreen extends StatefulWidget {
  final int postId;
  final int toUser;
  const ViewPostScreen({super.key, required this.postId, required this.toUser});

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  var controller = Get.put(PostCommentController());
  var viewPostController = Get.put(ViewPostController());
  @override
  void initState() {
    viewPostController.getPosts(widget.postId).whenComplete(() {
      if (viewPostController.isPostAvailable) {
        controller.getPostComments(widget.postId);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: GetBuilder<PostCommentController>(builder: (value) {
        return GetBuilder<ViewPostController>(builder: (viewPostValue) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: viewPostValue.loading
                ? AppViews.showLoading()
                : !viewPostController.isPostAvailable
                    ? Center(
                        child: Text(
                          'Post unavailable',
                          style: headingText(size: 16),
                        ),
                      )
                    : Stack(
                        children: [
                          ListView(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              backArrowAppBar('', isCentered: true),
                              const SizedBox(
                                height: 10,
                              ),
                              UserPost(
                                  post: viewPostValue.postModel[0],
                                  onLike: () {}),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),
                              value.mShowData
                                  ? Center(
                                      child: SpinKitThreeBounce(
                                          color: AppColors.primaryColor),
                                    )
                                  : ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: ((context, index) =>
                                          const SizedBox(
                                            height: 20,
                                          )),
                                      itemCount: value.comments.length,
                                      itemBuilder: ((context, index) {
                                        return _commentWidget(
                                            value.comments[index]);
                                      })),
                              SizedBox(
                                height: value.isShowEmojis ? 260 : 60,
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [_textField(context), _emojiSection()],
                            ),
                          ),
                        ],
                      ),
          );
        });
      })),
    );
  }

  GestureDetector _commentWidget(PostComments comment) {
    return GestureDetector(
      onTap: () {},
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
          child: Container(
            color: Colors.white,
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
                return value.showSendButton
                    ? InkWell(
                        onTap: () {
                          Get.find<PostController>()
                              .commentPost(widget.postId, widget.toUser,
                                  value.controllerMessage.text.trim())
                              .then((id) {
                            value.addNewComment(id);
                          });
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
