import 'package:flutter/material.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: wd(15)),
          children: [
            Text(
              'NOTIFICATIONS',
              style: subHeadingText(size: 25),
            ),
            SizedBox(
              height: ht(30),
            ),
            ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (contest, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.sparkliteblue4,
                            child: Image.asset(
                              index % 2 == 0
                                  ? 'assets/images/ic_coin.png'
                                  : 'assets/images/ic_money.png',
                              height: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Congratulations',
                                      style: subHeadingText(
                                          size: 18, color: AppColors.green),
                                    ),
                                  ),
                                  Text(
                                    '25 April, 2023',
                                    style: regularText(
                                        color: AppColors.ghostGrey, size: 10),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'You have secured a position in a contest. Please tap here to see details',
                                style: normalText(),
                              )
                            ],
                          ))
                        ],
                      ));
                })
          ]),
    );
  }
}
