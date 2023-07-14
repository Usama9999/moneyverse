import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/auth_controllers/forgor_password.dart';
import 'package:talentogram/controllers/auth_controllers/login_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/screens/auth_screens/forget_password.dart';
import 'package:talentogram/screens/auth_screens/sign_up.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var controller = Get.put(LoginController());
  var s = Get.put(ForgotPasswordController());
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
                    customTextFiled(
                        controller.controllerEmail, controller.focusNodeEmail,
                        onTap: () {
                      controller.getSaved();
                    },
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
                    const SizedBox(
                      height: 10,
                    ),
                    _rememberMeForgetPassword(),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          label: 'Login',
                          onPress: () => controller.loginTask(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: 30,
                          child: Text(
                            "Don't Have An Account?",
                            style: regularText(size: 13),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const SignUp());
                          },
                          child: SizedBox(
                            height: 30,
                            child: Text(
                              ' Sign Up',
                              style: headingText(size: 13)
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.loginWithGoogle();
                          },
                          child: Image.asset(
                            'assets/images/google.png',
                            height: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<LoginController>(builder: (value) {
              return Visibility(
                visible: value.isLoading,
                child: Container(
                  color: Colors.white60,
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: AppViews.showLoading()),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  _rememberMeForgetPassword() => Row(
        children: [
          GetBuilder<LoginController>(builder: (value) {
            return Container(
              margin: const EdgeInsets.only(left: 3),
              height: 18,
              width: 18,
              child: Checkbox(
                  fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                  value: value.isRememberMe,
                  onChanged: (check) => controller.rememberMe(check!)),
            );
          }),
          Expanded(
            child: Text(
              ' Remember Me',
              style: regularText(size: 13),
            ),
          ),
          InkWell(
            onTap: () => Get.to(() => const ForgetPassword()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Forget Password?',
                style: subHeadingText(size: 13, color: AppColors.sparkblue),
              ),
            ),
          )
        ],
      );
}
