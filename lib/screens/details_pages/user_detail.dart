import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:talentogram/controllers/detail_pages_controllers/other_user_profile.dart';
import 'package:talentogram/controllers/mainScreen_controllers/stats_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class OtherUserScreen extends StatefulWidget {
  const OtherUserScreen({super.key});

  @override
  State<OtherUserScreen> createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen> {
  var cont = Get.put(OtherUserProfileController());

  @override
  void initState() {
    // cont.getMyStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('', isMain: true),
      body: GetBuilder<MyStatsController>(builder: (value) {
        return Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: wd(15)),
              children: [
                Text(
                  'My Stats',
                  style: subHeadingText(size: 25),
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
                      animationDuration: const Duration(milliseconds: 800),
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
                          legendTextStyle:
                              regularText(color: AppColors.textGrey, size: 13)),
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
                Text(
                  'EARNING CHART',
                  style: subHeadingText(),
                ),
                SizedBox(
                  height: ht(30),
                ),
                // SizedBox(height: ht(250), child: LineChartCustom()),
              ],
            ),
            AppViews.loadingScreen(value.loading)
          ],
        );
      }),
    );
  }

  Row topRow(MyStatsController value) {
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
                          value.response.containsKey('userMeta')
                              ? value.response['userMeta']['earnings']
                                  .toString()
                              : "0",
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
                  'TOKENS',
                  style: regularText(color: AppColors.yellow, size: 11),
                ),
                SizedBox(
                  height: ht(3),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_coin.png',
                      height: ht(15),
                    ),
                    SizedBox(
                      width: wd(10),
                    ),
                    Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          value.response.containsKey('userMeta')
                              ? (value.response['userMeta']['balance'] ?? '0')
                                  .toString()
                              : "0",
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
      ],
    );
  }
}
