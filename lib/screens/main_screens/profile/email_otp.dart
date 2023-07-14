import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/mainScreen_controllers/profile_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/extensions/color_extensions.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/otp/src/otp_pin_field_input_type.dart';
import 'package:talentogram/globals/widgets/otp/src/otp_pin_field_style.dart';
import 'package:talentogram/globals/widgets/otp/src/otp_pin_field_widget.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/screens/auth_screens/create_new_password.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/login_details.dart';
import 'package:talentogram/utils/text_styles.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  FocusNode focusNode = FocusNode();

  PageController page = PageController();
  TextEditingController mControllerOTP = TextEditingController();

  int code = 0;
  String email = '';

  bool loading = false;

  Map args = {};

  @override
  void initState() {
    args = Get.arguments ?? {};
    code = args['code'];
    email = Get.find<UserDetail>().email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar:
      appBar: customAppBar(''),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: wd(15)),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(35))),
                    height: double.infinity,
                    width: double.infinity,
                    child: otpPage()),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      label: 'Submit',
                      onPress: () async {
                        if (args['screen'] == 'forgot') {
                          Get.off(() => const NewPasswordScreen());
                          return;
                        }
                        if (mControllerOTP.text == code.toString()) {
                          Global.showToastAlert(
                              context: Get.overlayContext!,
                              strTitle: "",
                              strMsg: 'Verified Successfully',
                              toastType: TOAST_TYPE.toastSuccess);
                          Get.find<UserDetail>().verify();
                          Get.find<ProfileController>().verifyUser();
                          Get.back();
                        } else {
                          Global.showToastAlert(
                              context: Get.overlayContext!,
                              strTitle: "",
                              strMsg: 'Incorrect code',
                              toastType: TOAST_TYPE.toastError);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppViews.loadingScreen(loading)
        ],
      ),
    );
  }

  ListView otpPage() {
    return ListView(
      children: [
        Text(
          'My Code is',
          style: subHeadingText(size: 25),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'We have sent a verification code to:',
          style: normalText(size: 16),
        ),
        Text(
          email,
          style: regularText(size: 16),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          child: OtpPinField(
            otpPinFieldInputType: OtpPinFieldInputType.none,
            onSubmit: (text) {
              mControllerOTP.text = text;
              setState(() {});
            },
            otpPinFieldStyle: OtpPinFieldStyle(
              defaultFieldBorderColor: AppColors.sparkblue,
              activeFieldBorderColor: AppColors.sparkblue,
              defaultFieldBackgroundColor: Colors.white,
              activeFieldBackgroundColor: HexColor(
                  '#f5f5f5'), // Background Color for active/focused Otp_Pin_Field
            ),
            maxLength: 6,
            highlightBorder: true,
            fieldHeight: 60,
            keyboardType: TextInputType.number,
            autoFocus: true,
            otpPinFieldDecoration:
                OtpPinFieldDecoration.defaultPinBoxDecoration,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: () async {
            int? c = await Get.find<ProfileController>().sendVerifyLink();
            if (c != null) {
              code = c;
            }
          },
          child: Text(
            'Resend',
            style: headingText(color: AppColors.sparkblue),
          ),
        )
      ],
    );
  }
}
