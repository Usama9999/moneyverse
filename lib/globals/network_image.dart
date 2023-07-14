import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageCustom extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final double radius;
  final BoxFit? fit;
  final bool isProfile;
  final bool isWinner;

  const NetworkImageCustom({
    Key? key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.radius = 0,
    required this.image,
    this.fit,
    this.isProfile = false,
    this.isWinner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
          // placeholder: ((context, url) =>
          //     Image.asset('assets/images/placeholderVideo.png')),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Container(),
          height: height,
          width: width,
          imageUrl: image == ''
              ? 'https://d23jwszswncmo3.cloudfront.net/otobuckslogo.jpg'
              : image,
          errorWidget: ((context, url, error) => Container()),
          fit: fit != null ? fit! : BoxFit.cover),
    );
  }
}
