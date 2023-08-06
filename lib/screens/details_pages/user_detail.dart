import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:talentogram/controllers/detail_pages_controllers/other_user_profile.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/screens/chat_view/chat_room.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/firebase_database.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

class OtherUserScreen extends StatefulWidget {
  final int userId;
  const OtherUserScreen({super.key, required this.userId});

  @override
  State<OtherUserScreen> createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen> {
  var cont = Get.put(OtherUserProfileController());

  @override
  void initState() {
    cont.getProifle(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: GetBuilder<OtherUserProfileController>(builder: (value) {
        return value.error
            ? Center(child: Lottie.asset('assets/lottie/error_lottie.json'))
            : value.loading
                ? AppViews.loadingScreen(value.loading)
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: wd(15)),
                    children: [
                      Text(
                        'User Profile',
                        style: subHeadingText(size: 25),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ht(25)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.sparkblue,
                              radius: 43,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: NetworkImageCustom(
                                    image: value
                                        .otherUserProfile.userDetails.image,
                                    radius: 100,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: wd(10),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${value.otherUserProfile.userDetails.firstName} ${value.otherUserProfile.userDetails.lastName}",
                                  style: headingText(size: 22),
                                ),
                                value.otherUserProfile.userDetails.isVerified
                                    ? Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/verified.png',
                                            color: AppColors.sparkblue,
                                            height: 18,
                                          ),
                                          Text(
                                            "Verified",
                                            style: regularText(size: 12),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Image.asset(
                                              height: 20,
                                              'assets/images/close.png'),
                                          Text(
                                            "Not verified",
                                            style: regularText(size: 12),
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: ht(10), bottom: ht(20)),
                        child: topRow(value),
                      ),
                      Text(
                        'CONTSET HISTORY',
                        style: subHeadingText(),
                      ),
                      SizedBox(
                        height: ht(20),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: ht(10)),
                          child: PieChart(
                            dataMap: value.dataMap,
                            animationDuration:
                                const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 2,
                            colorList: value.colorList,
                            initialAngleInDegree: 0,
                            chartType: ChartType.disc,
                            ringStrokeWidth: 32,
                            centerText: "",
                            legendOptions: LegendOptions(
                                showLegendsInRow: true,
                                legendPosition: LegendPosition.bottom,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: regularText(
                                    color: AppColors.textGrey, size: 13)),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 0,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          )),
                      SizedBox(
                        height: ht(20),
                      ),
                    ],
                  );
      }),
    );
  }

  Row topRow(OtherUserProfileController value) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: ht(60),
            decoration: ContainerProperties.shadowDecoration(opacity: 0.2),
            padding: EdgeInsets.symmetric(horizontal: wd(10)),
            margin: EdgeInsets.symmetric(vertical: ht(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EARNINGS',
                  style: regularText(color: AppColors.green, size: 11),
                ),
                SizedBox(
                  height: ht(6),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_money.png',
                      height: ht(17),
                    ),
                    SizedBox(
                      width: ht(3),
                    ),
                    Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          value.otherUserProfile.userDetails.earningHidden
                              ? "Hidden"
                              : value.otherUserProfile.userDetails.earnings
                                  .toString(),
                          style: subHeadingText(color: AppColors.sparkblue),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (widget.userId != Get.find<UserDetail>().userId)
          Expanded(
            child: GestureDetector(
              onTap: () {
                FireDatabase.createChatRoom(value.otherUserProfile.userDetails)
                    .then((id) {
                  if (id.isNotEmpty) {
                    Get.to(() => ChatDetailScreen(
                          roomId: id['room'],
                          userId: id['id'],
                          image: id['image'],
                          name: id['name'],
                        ));
                  }
                });
              },
              child: Container(
                height: ht(60),
                decoration: ContainerProperties.shadowDecoration(
                    opacity: 0.2, color: AppColors.sparkliteblue4),
                padding: EdgeInsets.symmetric(horizontal: wd(10)),
                margin: EdgeInsets.symmetric(vertical: ht(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chat',
                      style: regularText(color: AppColors.yellow, size: 12),
                    ),
                    SizedBox(
                      height: ht(3),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/ic_chat.png',
                          height: ht(15),
                          color: AppColors.sparkblue,
                        ),
                        SizedBox(
                          width: wd(10),
                        ),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Chat with User',
                              style: subHeadingText(color: AppColors.sparkblue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
