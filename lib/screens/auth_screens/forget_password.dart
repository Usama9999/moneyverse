import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/auth_controllers/forgor_password.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var controller = Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Forgot Password', isCentered: true),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 100, bottom: 50),
                        child: Image.asset(
                          'assets/images/full_logo.png',
                          width: wd(230),
                        ),
                      ),
                      customTextFiled(
                          controller.emailController, controller.emailNode,
                          hint: 'Enter you email'),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            label: 'Forgot Password',
                            onPress: () {
                              controller.resestPassowrd();
                            },
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
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
                    child: Center(child: AppViews.showLoading()),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
