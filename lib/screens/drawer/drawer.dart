import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/mainScreen_controllers/navbar_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/network_image.dart';
import 'package:talentogram/globals/widgets/dialogues/delete_acc.dart';
import 'package:talentogram/screens/drawer/items/invite_earn.dart';
import 'package:talentogram/screens/drawer/items/notifications.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

import '../../globals/widgets/dialogues/signout.dart';
import 'items/my_transactions.dart';
import 'items/my_wallet.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Container(
        width: SizeConfig.screenWidth / 1.5,
        decoration: const BoxDecoration(
            color: AppColors.scaffoldBacground,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20))),
        child: Column(
          children: [
            topContainer(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  optionItem("My Wallet", () {
                    Get.back();
                    Get.to(() => const MyWallet());
                  }),
                  divider(),
                  optionItem("Profile", () {
                    Get.back();
                    Get.find<NavBarController>().changeTab(4);
                  }),
                  optionItem("Transactions", () {
                    Get.back();
                    Get.to(() => const MyTransaction());
                  }),
                  optionItem("Notifications", () {
                    Get.back();
                    Get.to(() => const Notifications());
                  }),
                  divider(),
                  optionItem("Invite & Earn", () {
                    Get.back();
                    Get.to(() => const InviteFriends());
                  }, color: AppColors.orange, size: 9),
                  optionItem("Help", () {
                    Get.back();
                  }, color: AppColors.orange, size: 9),
                  divider(),
                  optionItem("Sign Out", () {
                    showDialog(
                        context: context,
                        builder: (_) => const SignoutDialoge());
                  }, color: AppColors.textGrey, size: 9),
                  optionItem("Delete Account", () {
                    showDialog(
                        context: context,
                        builder: (_) => const DeleteAccountDialoge());
                  }, color: AppColors.red, size: 9),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 1,
      width: double.infinity,
      color: AppColors.colorGray.withOpacity(0.4),
    );
  }

  GestureDetector optionItem(String title, Function ontap,
      {var color = const Color(0xFFFAD202), double size = 11}) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        height: 50,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              height: size,
              width: size,
              decoration: ContainerProperties.simpleDecoration(color: color),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              title,
              style: regularText(
                  size: 16,
                  color: title == 'Delete Account'
                      ? AppColors.red
                      : AppColors.colorGray),
            ))
          ],
        ),
      ),
    );
  }

  Container topContainer() {
    return Container(
        margin: const EdgeInsets.only(bottom: 30),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 10)
            ],
            color: AppColors.sparkliteblue3,
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(20))),
        width: double.infinity,
        height: ht(120),
        padding: EdgeInsets.only(left: wd(15), bottom: ht(20)),
        child: GetBuilder<UserDetail>(builder: (value) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Get.find<NavBarController>().openDrawer();
                  // Get.to(() => const LogoutScreen());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: NetworkImageCustom(
                    image: value.image,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  value.name,
                  style: regularText(size: 16),
                ),
              ),
            ],
          );
        }));
  }
}
