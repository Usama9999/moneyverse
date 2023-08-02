import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:talentogram/controllers/mainScreen_controllers/navbar_controller.dart';
import 'package:talentogram/controllers/mainScreen_controllers/profile_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/extensions/color_extensions.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/circle_badge.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/screens/auth_screens/create_new_password.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

import 'bank_details_screen.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var cont = Get.put(ProfileController());
  @override
  void initState() {
    cont.getCompletionStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar('', isMain: true),
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (value) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: wd(15)),
              children: [
                Text(
                  'Profile',
                  style: subHeadingText(size: 25),
                ),
                SizedBox(
                  height: ht(50),
                ),
                _verifyEditProfilePic(),
                SizedBox(
                  height: ht(25),
                ),
                profileStatuses(),
                const SizedBox(
                  height: 30,
                ),
                if (!value.profileLoading) profileComplete(),
                const SizedBox(
                  height: 100,
                )
              ],
            );
          }),
    );
  }

  Column profileStatuses() {
    return Column(
      children: [
        GetBuilder<UserDetail>(builder: (value) {
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: ContainerProperties.simpleDecoration(
                    radius: 60, color: AppColors.sparkliteblue4),
                height: wd(30),
                width: wd(30),
                child: Image.asset(
                  !value.isEarningVisible
                      ? 'assets/images/hide.png'
                      : 'assets/images/show.png',
                  color: AppColors.sparkblue,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                'Your Earning is ${value.isEarningVisible ? "Visible" : "Hidden"}',
                style: subHeadingText(size: 15),
              )),
              SizedBox(
                width: 35,
                child: Switch(
                    activeTrackColor: AppColors.primaryColor,
                    activeColor: AppColors.primaryColor,
                    value: value.isEarningVisible,
                    onChanged: (k) => value.editVisibility()),
              )
            ],
          );
        }),
        const SizedBox(
          height: 17,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ContainerProperties.simpleDecoration(
                  radius: 60, color: AppColors.sparkliteblue4),
              height: wd(30),
              width: wd(30),
              child: Image.asset(
                'assets/images/bank.png',
                color: AppColors.sparkblue,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              'Your Bank Details',
              style: subHeadingText(size: 15),
            )),
            forwardButton(() {
              Get.to(() => const BankDetailScreen());
            })
          ],
        ),
        const SizedBox(
          height: 23,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: ContainerProperties.simpleDecoration(
                  radius: 60, color: AppColors.sparkliteblue4),
              height: wd(30),
              width: wd(30),
              child: Image.asset(
                'assets/images/ic_stats.png',
                color: AppColors.sparkblue,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              'Your Statistics',
              style: subHeadingText(size: 15),
            )),
            forwardButton(() {
              Get.find<NavBarController>().changeTab(3);
            })
          ],
        ),
        const SizedBox(
          height: 23,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ContainerProperties.simpleDecoration(
                  radius: 60, color: AppColors.sparkliteblue4),
              height: wd(30),
              width: wd(30),
              child: Image.asset(
                'assets/images/lock.png',
                color: AppColors.sparkblue,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              'Change Your Password',
              style: subHeadingText(size: 15),
            )),
            forwardButton(() {
              Get.to(() => const NewPasswordScreen(
                    changePassword: true,
                  ));
            })
          ],
        ),
      ],
    );
  }

  InkWell forwardButton(Function ontap, {isActive = false}) {
    return InkWell(
      onTap: () => ontap(),
      child: Center(
        child: Container(
          decoration: ContainerProperties.simpleDecoration(
              radius: 8, color: AppColors.primaryColor),
          alignment: Alignment.center,
          height: ht(34),
          width: wd(23),
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.colorWhite,
            size: 15,
          ),
        ),
      ),
    );
  }

  Widget _verifyEditProfilePic() {
    //print('userDetails: ${userDetails.data!}');

    return GetBuilder<UserDetail>(builder: (value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //verify now button
          value.isVerified
              ? CircleBtnTxt(
                  text: '  Verified  ',
                  icon: 'assets/images/verified.png',
                  isDisabled: true,
                  callback: () {},
                )
              : CircleBtnTxt(
                  text: '  Verified  ',
                  icon: 'assets/images/close.png',
                  isDisabled: true,
                  callback: () {},
                ),

          SizedBox(width: wd(15)),

          Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.sparkblue,
                radius: 73,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: NetworkImageCustom(
                      image: value.image,
                      radius: 100,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ht(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<UserDetail>(builder: (value) {
                    return Text(value.name.capitalizeFirst!,
                        style: subHeadingText(
                            size: 20, color: AppColors.sparkblue));
                  }),
                ],
              ),
            ],
          ),

          SizedBox(width: wd(15)),
          //edit profile
          CircleBtnTxt(
            text: 'Edit Profile',
            icon: 'assets/images/edit.png',
            isDisabled: false,
            callback: () {
              Get.to(() => const EditProfile());
            },
          ),
        ],
      );
    });
  }

  Widget profileComplete() {
    return SizedBox(
      height: ht(140),
      child: Stack(children: [
        Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.only(bottom: 20, left: wd(0)),
            height: ht(140),
            decoration: ContainerProperties.shadowDecoration(
                color: AppColors.sparkliteblue4, radius: 10)),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Center(
                child: CircularPercentIndicator(
                  radius: 44.0,
                  lineWidth: 8.5,
                  percent: cont.getComppletePrecentage().toDouble() / 100,
                  center: CircularPercentIndicator(
                    radius: 35.0,
                    lineWidth: 5.0,
                    percent: 1,
                    center: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "${cont.getComppletePrecentage()}%",
                            style: headingText(size: 13),
                          ),
                        )),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColors.colorWhite,
                    backgroundColor: Colors.transparent,
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: HexColor('#FF9C27'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: ht(20), right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You have completed ${cont.getComppletePrecentage()}% of your Profile.',
                        style: regularText(color: AppColors.sparkblue),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        cont.getComppletePrecentage() != 100
                            ? 'Please complete your profile so we can pay you when its time. '
                            : 'Your profile is 100% completed. Thank you for your cooperation',
                        style: normalText(color: AppColors.textGrey),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            right: 20,
            child: SizedBox(
                width: 120,
                child: CustomButton(
                  enable: cont.getComppletePrecentage() != 100,
                  label: cont.getComppletePrecentage() != 100
                      ? 'COMPLETE'
                      : 'COMPLETED',
                  onPress: () {
                    cont.checkCompletion();
                  },
                  buttonHight: 40,
                  textSize: 16,
                )))
      ]),
    );
  }
}
