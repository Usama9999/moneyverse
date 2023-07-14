import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/mainScreen_controllers/profile_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController controller = Get.put(ProfileController());
  var user = Get.find<UserDetail>();

  @override
  void initState() {
    controller.emailCont.text = user.email;
    controller.firstNameCont.text = user.name.split(' ')[0];
    controller.lastNameCont.text = user.name.split(' ')[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('', isCentered: true),
      body: GetBuilder<ProfileController>(builder: (value) {
        return Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: wd(15)),
              children: [
                Text(
                  'Edit Profile',
                  style: subHeadingText(size: 25),
                ),
                SizedBox(
                  height: ht(40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.sparkblue,
                      radius: SizeConfig.screenWidth * 0.185,
                      child: InkWell(
                        radius: SizeConfig.screenWidth * 0.18,
                        borderRadius: BorderRadius.circular(60),
                        onTap: () {
                          value.showImagePicker(context);
                        },
                        child: GetBuilder<UserDetail>(builder: (user) {
                          return CircleAvatar(
                            radius: SizeConfig.screenWidth * 0.18,
                            backgroundImage: value.imageFile == null
                                ? NetworkImage(user.image)
                                : FileImage(
                                    File(value.imageFile!.path),
                                  ) as ImageProvider?,
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    top: SizeConfig.screenWidth * 0.24,
                                    right: -5,
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 28,
                                      color: AppColors.sparkblue,
                                    ))
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                textField(value.emailCont, value.emailNode, "Email",
                    readOnly: true),
                textField(
                    value.firstNameCont, value.firstNameNode, "First Name"),
                textField(value.lastNameCont, value.lastNameNode, "Last Name"),
                SizedBox(
                  height: ht(18),
                ),
                CustomButton(
                    label: "Update",
                    onPress: () {
                      value.updateProfile();
                    })
              ],
            ),
            AppViews.loadingScreen(value.loading)
          ],
        );
      }),
    );
  }

  Column textField(cont, node, hint, {readOnly = false, maxline = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ht(18),
        ),
        Text(
          " " + hint,
          style: normalText(),
        ),
        const SizedBox(
          height: 8,
        ),
        customTextFiled(cont, node,
            hint: hint,
            readOnly: readOnly,
            icon: readOnly
                ? GetBuilder<UserDetail>(builder: (val) {
                    return val.isVerified
                        ? SizedBox(
                            height: 55,
                            width: 70,
                            child: Center(
                              child: Text(
                                'Verified',
                                style: subHeadingText(color: AppColors.green),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              controller.sendVerifyLink();
                            },
                            child: SizedBox(
                              height: 55,
                              width: 70,
                              child: Center(
                                child: Text(
                                  'Verify',
                                  style: subHeadingText(
                                      color: AppColors.sparkblue),
                                ),
                              ),
                            ),
                          );
                  })
                : null)
      ],
    );
  }
}
