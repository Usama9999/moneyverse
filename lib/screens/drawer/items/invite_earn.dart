import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/services/dynamic_links.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  InviteFriendsState createState() => InviteFriendsState();
}

class InviteFriendsState extends State<InviteFriends> {
  TextEditingController codeController = TextEditingController(text: '');

  FocusNode codeNode = FocusNode();

  getLink() async {
    codeController.text = await DynamicLinksApi().createShareLink();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: customAppBar(''),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: wd(20)),
            children: [
              SizedBox(
                height: ht(10),
              ),
              Text(
                'Invite friends',
                style: regularText(size: 36, color: AppColors.sparkblue),
              ),
              SizedBox(
                height: ht(15),
              ),
              GetBuilder<UserDetail>(builder: (value) {
                return Text(
                  '${value.name}, let’s grow our community!',
                  style: normalText(size: 16, color: AppColors.secondaryText),
                );
              }),
              SizedBox(
                height: ht(40),
              ),
              Container(
                height: ht(230),
                child: Stack(
                  children: [
                    Container(
                      height: ht(210),
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 1, left: 1, right: 1, bottom: 8),
                      decoration: ContainerProperties.simpleDecoration(
                        radius: 16,
                        color: AppColors.sparkliteblue,
                      ),
                      child: Container(
                        decoration: ContainerProperties.simpleDecoration(
                          radius: 16,
                          color: AppColors.colorWhite,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: wd(14), vertical: ht(28)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invite your friends and earn 5 MoneyVerse Tokens!',
                              style: headingText(
                                  color: AppColors.sparkblue, size: 20),
                            ),
                            SizedBox(
                              height: ht(24),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: wd(30)),
                              child: customTextFiled(codeController, codeNode,
                                  readOnly: true,
                                  align: TextAlign.center,
                                  hint: 'Creating Link... Please wait'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                width: 170,
                                child: Center(
                                  child: CustomButton(
                                      label: "Copy Code",
                                      onPress: () {
                                        Clipboard.setData(ClipboardData(
                                            text: codeController.text));
                                      }),
                                ),
                              ),
                            )),
                            Center(
                              child: RoundButton(
                                size: 45,
                                onTap: () async {
                                  if (codeController.text.isNotEmpty) {
                                    Share.share(codeController.text);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Image.asset('assets/images/ic_share.png'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                width: double.infinity,
                padding:
                    const EdgeInsets.only(top: 1, left: 1, right: 1, bottom: 8),
                decoration: ContainerProperties.simpleDecoration(
                  radius: 16,
                  color: AppColors.textGrey,
                ),
                child: Container(
                  decoration: ContainerProperties.simpleDecoration(
                    radius: 16,
                    color: AppColors.colorWhite,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: wd(14), vertical: ht(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How does it work?',
                        style: normalText(
                            color: AppColors.secondaryText, size: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      starRow(
                          'Invite your friends or relatives on MoneyVerse.'),
                      starRow('Share your invitation link to them.'),
                      starRow(
                          'Ask them to download the app using your link and open it.'),
                      starRow('You get 5 tokens upon successful signup.'),
                      starRow(
                          'Signing up with different accounts on same device will not award you.')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Container starRow(text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            text,
            style: normalText(color: AppColors.textGrey),
          ))
        ],
      ),
    );
  }
}
