import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

class DeleteAccountDialoge extends StatefulWidget {
  const DeleteAccountDialoge({
    Key? key,
  }) : super(key: key);

  @override
  DeleteAccountDialogeState createState() => DeleteAccountDialogeState();
}

class DeleteAccountDialogeState extends State<DeleteAccountDialoge> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 3),
                    blurRadius: 5),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Are you sure you want to Delete your MoneyVerse Acconut? ",
                textAlign: TextAlign.center,
                style: regularText(size: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Get.back();
                      },
                      child: Text(
                        'CANCEL',
                        style: headingText(
                            color: AppColors.colorGray.withOpacity(0.5),
                            size: 20),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        Get.find<UserDetail>().logout();
                      },
                      child: Text(
                        'DELETE',
                        style: headingText(color: AppColors.red, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
