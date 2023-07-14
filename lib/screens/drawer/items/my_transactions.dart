import 'package:flutter/material.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class MyTransaction extends StatefulWidget {
  const MyTransaction({super.key});

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: wd(15)),
        children: [
          Text(
            'MY TRANSACTIONS',
            style: subHeadingText(size: 25),
          ),
          SizedBox(
            height: ht(30),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (contest, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: ContainerProperties.shadowDecoration(),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.sparkliteblue4,
                      child: Image.asset(
                        index % 2 == 0
                            ? 'assets/images/ic_coin.png'
                            : 'assets/images/ic_money.png',
                        height: 25,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '+100',
                            style: subHeadingText(
                                size: 18, color: AppColors.green),
                          ),
                        ),
                        Text(
                          'CREDITED',
                          style:
                              regularText(color: AppColors.ghostGrey, size: 10),
                        )
                      ],
                    ),
                    subtitle: const Text('Credited on 25 Feb 2023'),
                  ),
                );
              })
        ],
      ),
    );
  }
}
