import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/auth_controllers/signup_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 100, bottom: 50),
                      child: Image.asset(
                        'assets/images/full_logo.png',
                        width: wd(230),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customTextFiled(
                              controller.firstName, controller.firstNameNode,
                              hint: 'First Name'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: customTextFiled(
                              controller.lastName, controller.lastNameNode,
                              hint: 'Last Name'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customTextFiled(
                        controller.controllerEmail, controller.focusNodeEmail,
                        textInputType: TextInputType.emailAddress,
                        hint: 'Email'),
                    const SizedBox(
                      height: 15,
                    ),
                    customTextFiled(
                      controller.controllerPassword,
                      controller.focusNodePassword,
                      hint: 'Password',
                      obscure: true,
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // customTextFiled(
                    //     controller.controllerInvite, controller.focusNodeInvite,
                    //     textInputType: TextInputType.number,
                    //     obscure: false,
                    //     hint: 'Invite Code'),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          label: 'SignUp',
                          onPress: () {
                            controller.createUser();
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    _signin(),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<SignUpController>(builder: (value) {
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

  _signin() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: Text(
              'Already Have An Account?',
              style: regularText(size: 13),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              height: 30,
              child: Text(
                ' Sign In',
                style: headingText(size: 13)
                    .copyWith(color: AppColors.primaryColor),
              ),
            ),
          )
        ],
      );
}
