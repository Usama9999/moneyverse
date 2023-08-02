import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talentogram/utils/app_colors.dart';

class ImageView extends StatelessWidget {
  final String url;
  ImageView(this.url);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        child: CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: CircularProgressIndicator(
            backgroundColor: AppColors.primaryColor,
            color: Colors.grey,
            value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ));
  }
}
