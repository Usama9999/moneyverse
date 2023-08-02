import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:talentogram/screens/view_post_screen.dart';
import 'package:talentogram/utils/login_details.dart';

class DynamicLinksApi {
  final dynamicLink = FirebaseDynamicLinks.instance;

  handleDynamicLink() async {
    PendingDynamicLinkData? pendingDynamicLinkData =
        await dynamicLink.getInitialLink();
    if (pendingDynamicLinkData != null) {
      handleSuccessLinking(pendingDynamicLinkData);
    }
    dynamicLink.onLink.listen((dynamicLinkData) {
      handleSuccessLinking(dynamicLinkData);
    }).onError((error) {
      log('onLink error');
      log(error.message);
    });
  }

  Future<String> createShareLink() async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://moneyverse.page.link',
      link: Uri.parse(
          'https://moneyverse.com/invite?email=${Get.find<UserDetail>().email}'),
      androidParameters: const AndroidParameters(
          packageName: 'com.moneyverse.app', minimumVersion: 0),
      socialMetaTagParameters: const SocialMetaTagParameters(
        title: 'Signup to MoneyVerse using this link',
        description: 'Participate in excitig contests and win real cash prices',
      ),
    );

    final ShortDynamicLink shortLink =
        await dynamicLink.buildShortLink(dynamicLinkParameters);

    final Uri dynamicUrl = shortLink.shortUrl;
    return dynamicUrl.toString();
  }

  Future<String> createProfiletLink(
    String image,
    String name,
    String userId,
  ) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://moneyverse.page.link',
      link: Uri.parse('https://moneyverse.com/profilelink?userId=$userId'),
      androidParameters: const AndroidParameters(
          packageName: 'com.moneyverse.app', minimumVersion: 0),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: name,
        description: 'Check this profile',
        imageUrl: Uri.parse(image),
      ),
    );

    final ShortDynamicLink shortLink =
        await dynamicLink.buildShortLink(dynamicLinkParameters);

    final Uri dynamicUrl = shortLink.shortUrl;
    return dynamicUrl.toString();
  }

  Future<void> handleSuccessLinking(PendingDynamicLinkData data) async {
    final Uri deepLink = data.link;

    var isPost = deepLink.pathSegments.contains('postLink');
    if (isPost) {
      var postId = deepLink.queryParameters['postId'];
      var userId = deepLink.queryParameters['userId'];
      var login = await Get.find<UserDetail>().isLogin();
      if (login) {
        Get.to(() => ViewPostScreen(
            postId: int.parse(postId.toString()),
            toUser: int.parse(userId.toString())));
      }
    }
  }
}
