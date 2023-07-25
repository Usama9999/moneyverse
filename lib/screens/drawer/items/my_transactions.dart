import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/notification_trans_cont.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class MyTransaction extends StatefulWidget {
  const MyTransaction({super.key});

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  var controller = Get.put(NotTransController());

  @override
  void initState() {
    controller.getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: GetBuilder<NotTransController>(builder: (value) {
        return value.loading
            ? AppViews.showLoading()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: wd(15)),
                children: [
                  Text(
                    'MY TRANSACTIONS',
                    style: subHeadingText(size: 25),
                  ),
                  SizedBox(
                    height: ht(30),
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.transactions.length,
                      itemBuilder: (contest, index) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.sparkliteblue4,
                                  child: Image.asset(
                                    value.transactions[index].isToken
                                        ? 'assets/images/ic_coin.png'
                                        : 'assets/images/ic_money.png',
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
                                            '${value.transactions[index].isDebit ? "-" : "+"} ${value.transactions[index].amount}',
                                            style: subHeadingText(
                                                size: 18,
                                                color: value.transactions[index]
                                                        .isDebit
                                                    ? AppColors.red
                                                    : AppColors.green),
                                          ),
                                        ),
                                        Text(
                                          value.transactions[index].getNature,
                                          style: regularText(
                                              color: AppColors.ghostGrey,
                                              size: 10),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${value.transactions[index].getNature.capitalizeFirst} on ${value.transactions[index].getFormatedDate()}',
                                      style: normalText(),
                                    )
                                  ],
                                ))
                              ],
                            ));
                      })
                ],
              );
      }),
    );
  }
}
