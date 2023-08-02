import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/wallet_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  var controller = Get.put(WalletController());

  @override
  void initState() {
    controller.getTokens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: GetBuilder<WalletController>(builder: (value) {
        return value.loading
            ? AppViews.showLoading()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: wd(15)),
                children: [
                  Text(
                    'MY WALLET',
                    style: subHeadingText(size: 25),
                  ),
                  SizedBox(
                    height: ht(30),
                  ),
                  Container(
                    decoration: ContainerProperties.borderDecoration(
                        color: Colors.transparent, borderColor: Colors.black),
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        Text(
                          'YOUR TOKENS',
                          style: subHeadingText(
                              size: 26, color: AppColors.sparkYellow),
                        ),
                        SizedBox(
                          height: ht(30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/ic_coin.png',
                              height: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              value.userData['balance'].toString(),
                              style: subHeadingText(
                                  color: AppColors.primaryColor, size: 30),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ht(20),
                  ),
                  Text(
                    'BUY TOKENS',
                    style: subHeadingText(),
                  ),
                  SizedBox(
                    height: ht(20),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(
                        controller.offers.length,
                        (index) => Container(
                              decoration: ContainerProperties.shadowDecoration(
                                  radius: 15, color: AppColors.sparkliteblue5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/ic_coin.png',
                                        height: 26,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        controller.offers[index]['tokens']
                                            .toString(),
                                        style: subHeadingText(
                                            color: AppColors.sparkblue,
                                            size: 27),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: ht(5),
                                  ),
                                  Text(
                                    '  Rs. ${controller.offers[index]['amount']}',
                                    style: subHeadingText(
                                        color: AppColors.green, size: 13),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: CustomButton(
                                        buttonHight: 40,
                                        label: 'BUY',
                                        onPress: () {
                                          controller.makePayment(
                                              controller.offers[index]);
                                        }),
                                  )
                                ],
                              ),
                            )),
                  )
                ],
              );
      }),
    );
  }
}
