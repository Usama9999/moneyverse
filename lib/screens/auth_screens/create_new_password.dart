import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/auth_controllers/forgor_password.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/utils/text_styles.dart';

import '../../globals/loader/three_bounce.dart';
import '../../utils/app_colors.dart';

class NewPasswordScreen extends StatefulWidget {
  final bool changePassword;
  const NewPasswordScreen({Key? key, this.changePassword = false})
      : super(key: key);

  @override
  NewPasswordScreenState createState() => NewPasswordScreenState();
}

class NewPasswordScreenState extends State<NewPasswordScreen> {
  var controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar(''),
      body: GetBuilder<ForgotPasswordController>(builder: (value) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: wd(15)),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create new password',
                      style: subHeadingText(size: 25),
                    ),
                    SizedBox(height: ht(18)),
                    Text(
                      "Your new password must be unique from your previous passwords.",
                      style: normalText(size: 14),
                    ),
                    SizedBox(height: ht(57)),
                    Column(
                      children: [
                        if (widget.changePassword)
                          customTextFiled(controller.oldpasswordController,
                              controller.oldpasswordNode,
                              hint: 'Old password',
                              icon: GestureDetector(
                                  onTap: () {
                                    value.changeOldObscure();
                                  },
                                  child: Container(
                                      height: 55,
                                      width: 50,
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        !value.oldobscure
                                            ? "assets/images/show.png"
                                            : "assets/images/hide.png",
                                        height: 22,
                                      ))),
                              obscure: value.oldobscure),
                        SizedBox(height: ht(15)),
                      ],
                    ),
                    customTextFiled(
                        controller.passwordController, controller.passwordNode,
                        hint: 'New password',
                        icon: GestureDetector(
                            onTap: () {
                              value.changeObscure();
                            },
                            child: Container(
                                height: 55,
                                width: 50,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  !value.obscure
                                      ? "assets/images/show.png"
                                      : "assets/images/hide.png",
                                  height: 22,
                                ))),
                        obscure: value.obscure),
                    SizedBox(height: ht(15)),
                    customTextFiled(controller.confirmPasswordController,
                        controller.confirmPasswordNode,
                        hint: 'Confirm password',
                        icon: GestureDetector(
                            onTap: () {
                              value.changeObscureConfirm();
                            },
                            child: Container(
                                height: 55,
                                width: 50,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  !value.confirmObscure
                                      ? "assets/images/show.png"
                                      : "assets/images/hide.png",
                                  height: 22,
                                ))),
                        obscure: value.confirmObscure),
                    SizedBox(height: ht(30)),
                    CustomButton(
                        label: widget.changePassword
                            ? 'Update Password'
                            : 'Reset Password',
                        onPress: () {
                          if (widget.changePassword) {
                            controller.updatePassword();
                          } else {
                            controller.resetPassword();
                          }
                        }),
                  ],
                ),
              ),
              GetBuilder<ForgotPasswordController>(builder: (value) {
                return Visibility(
                  visible: value.isLoading,
                  child: Container(
                    color: Colors.white60,
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                        child:
                            SpinKitThreeBounce(color: AppColors.primaryColor)),
                  ),
                );
              })
            ],
          ),
        );
      }),
    );
  }
}
