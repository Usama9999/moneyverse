import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/notification_trans_cont.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/models/notification_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var controller = Get.put(NotTransController());

  @override
  void initState() {
    controller.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: GetBuilder<NotTransController>(builder: (value) {
        return ListView(
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
                  itemCount: value.notifications.length,
                  itemBuilder: (contest, index) {
                    NotificationModel notification = value.notifications[index];
                    return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.sparkliteblue4,
                              child: Image.asset(
                                'assets/images/${notification.getIcon()}',
                                height: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notification.title,
                                        style: subHeadingText(
                                            size: 18,
                                            color: notification.isWinner
                                                ? AppColors.green
                                                : AppColors.sparkblue),
                                      ),
                                    ),
                                    Text(
                                      notification.getFormatedDate(),
                                      style: regularText(
                                          color: AppColors.ghostGrey, size: 10),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  notification.message,
                                  style: normalText(),
                                )
                              ],
                            ))
                          ],
                        ));
                  })
            ]);
      }),
    );
  }
}
