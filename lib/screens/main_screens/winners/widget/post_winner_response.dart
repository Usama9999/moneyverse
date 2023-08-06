import 'package:flutter/material.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/components/post_video_view.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class UserPostResponse extends StatefulWidget {
  final Map post;
  const UserPostResponse({super.key, required this.post});

  @override
  State<UserPostResponse> createState() => _UserPostResponseState();
}

class _UserPostResponseState extends State<UserPostResponse> {
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
              const SizedBox(
                height: 10,
              ),
              if (widget.post['description'] != '')
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    widget.post['description'],
                    style: normalText(size: 16),
                  ),
                ),
              if (widget.post['videoLink'] != null)
                LayoutBuilder(builder: (context, size) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: ht(13)),
                    alignment: Alignment.center,
                    height: size.maxWidth + ht(120),
                    child: VideoPostComponent(
                      url: widget.post['videoLink'],
                    ),
                  );
                }),
              if (widget.post['imageLink'] != null)
                Container(
                  margin: EdgeInsets.symmetric(vertical: ht(13)),
                  height: ht(300),
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NetworkImageCustom(
                        image: widget.post['imageLink'],
                        fit: widget.post['coverImage'] == 1
                            ? BoxFit.cover
                            : BoxFit.contain,
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
                Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                  decoration: ContainerProperties.borderDecoration(
                      borderColor: AppColors.primaryColor,
                      radius: 100,
                      color: AppColors.colorWhite),
                  child: Row(
                    children: [
                      Text(
                        '${widget.post['likes']}  Likes',
                        style: normalText(
                          color: AppColors.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: wd(16),
                ),
              ],
            ))
      ],
    );
  }
}
