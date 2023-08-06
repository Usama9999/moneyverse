import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/screens/main_screens/bottom_bar_screen.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/bindings/initial_binding.dart';
import 'package:talentogram/globals/services/dynamic_links.dart';
import 'package:talentogram/globals/services/local_notifications_helper.dart';
import 'package:talentogram/globals/widgets/custome_scroll.dart';
import 'package:talentogram/screens/auth_screens/login.dart';

import 'package:talentogram/utils/app_theme_input_dec.dart';
import 'package:talentogram/utils/login_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var loginDetail = Get.put(UserDetail());
  Stripe.publishableKey = Constants.stripePublishKey;
  LocalNotificationChannel.initializer();
  loginDetail.getData();
  bool loggedIn = await loginDetail.isLogin();
  DynamicLinksApi().handleDynamicLink();

  runApp(
    OverlaySupport(
        child: BoosterMaterialApp(
      login: loggedIn,
    )), //
  );
}

class BoosterMaterialApp extends StatelessWidget {
  final bool login;
  const BoosterMaterialApp({Key? key, required this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrainst) {
        SizeConfig().init(context);
        return GetMaterialApp(
          title: "MoneyVerse",
          themeMode: ThemeMode.light,
          theme: AppTheme.data(),
          fallbackLocale: const Locale('en', 'US'),
          locale: const Locale('en', 'US'),
          defaultTransition: Transition.cupertino,
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBinding(),
          home: login ? const NavBarScreen() : const Login(),
          builder: (context, child) {
            //ignore system scale factor
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: ScrollConfiguration(
                  behavior: CustomBehavior(),
                  child: child!,
                ));
          },
        );
      },
    );
  }
}
