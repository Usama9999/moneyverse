import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/components/post_video_view.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/custom_bottom_option_sheet.dart';
import 'package:talentogram/globals/widgets/icons.dart';
import 'package:talentogram/models/post_model.dart';
import 'package:talentogram/screens/post_screens/post_comments_screen.dart';
import 'package:talentogram/utils/text_styles.dart';

import '../../screens/details_pages/user_detail.dart';
import '../../utils/app_colors.dart';

class UserPost extends StatefulWidget {
  final PostModel post;
  final Function onLike;
  const UserPost({super.key, required this.post, required this.onLike});

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: ht(20), bottom: 20),
          decoration: ContainerProperties.shadowDecoration(radius: 16)
              .copyWith(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: wd(10), vertical: ht(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Get.to(() => OtherUserScreen(
                      userId: widget.post.userId,
                    )),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: NetworkImageCustom(
                        image: widget.post.userImage,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  style: regularText(size: 16),
                                  text:
                                      "${widget.post.firstName} ${widget.post.lastName == widget.post.firstName ? '' : widget.post.lastName}",
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ThreeDotIcon(onTap: () {
                      customBottomSheet(context, ["Report"], -1, (val) {
                        String text = "Reported successfully";
                        Global.showToastAlert(
                          context: Get.overlayContext!,
                          strTitle: "ok",
                          strMsg: text,
                          toastType: TOAST_TYPE.toastSuccess,
                        );
                      });
                    })
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (widget.post.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    widget.post.description,
                    style: normalText(size: 16),
                  ),
                ),
              if (widget.post.isVideoPost)
                LayoutBuilder(builder: (context, size) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: ht(13)),
                    alignment: Alignment.center,
                    height: size.maxWidth + ht(120),
                    child: VideoPostComponent(
                      url: widget.post.videoLink,
                    ),
                  );
                }),
              if (widget.post.isImagePost)
                Container(
                  margin: EdgeInsets.symmetric(vertical: ht(13)),
                  height: ht(300),
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NetworkImageCustom(
                        image: widget.post.imageLink,
                        fit:
                            widget.post.isCover ? BoxFit.cover : BoxFit.contain,
                      )),
                ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                SizedBox(
                  width: wd(16),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onLike();
                  },
                  child: Container(
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    decoration: ContainerProperties.borderDecoration(
                      borderColor: AppColors.primaryColor,
                      radius: 100,
                      color: !widget.post.likedByMe
                          ? AppColors.colorWhite
                          : AppColors.primaryColor,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/ic_thumb.png',
                          color: widget.post.likedByMe
                              ? AppColors.colorWhite
                              : AppColors.primaryColor,
                        ),
                        Text(
                          '  Like',
                          style: normalText(
                            color: widget.post.likedByMe
                                ? AppColors.colorWhite
                                : AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: wd(16),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => PostCommentScreen(
                          postId: widget.post.postId,
                          toUser: widget.post.userId,
                        ));
                  },
                  child: Container(
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    decoration: ContainerProperties.borderDecoration(
                        borderColor: AppColors.primaryColor,
                        radius: 100,
                        color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/ic_comment.png',
                          color: AppColors.primaryColor,
                        ),
                        Text(
                          '  Comment',
                          style: normalText(color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
