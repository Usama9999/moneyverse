import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/loader/three_bounce.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

import 'global.dart';

class AppViews {
  // App bar inti

  // Show Center Loading
  static Widget loadingScreen(bool visible, {double opacity = 0.5}) {
    return Visibility(
      visible: visible,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.scaffoldBacground.withOpacity(opacity),
        child: Center(
          child: showLoading(),
        ),
      ),
    );
  } // Show Footer Loading Icon

  static Widget showGif(bool visible, String gif, {String text = ''}) {
    return Visibility(
      visible: visible,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.scaffoldBacground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/$gif.json'),
              Text(
                text,
                textAlign: TextAlign.center,
                style: subHeadingText(size: 22, color: AppColors.textGrey),
              )
            ],
          ),
        ),
      ),
    );
  } // Show Footer Loading Icon

  static showLoading() {
    return Center(
      child: Lottie.asset('assets/lottie/load.json'),
    );
  } // Show Footer Loading Icon

  static showLoadingWithStatus(bool isShowLoader) {
    return isShowLoader
        ? Container(
            child: AppViews.showLoading(),
            color: Colors.white70,
          )
        : const SizedBox(
            height: 0,
            width: 0,
          );
  } // Show Footer Loading Icon

  static showFooterLoading(bool isProgressBarBottomShown) {
    if (isProgressBarBottomShown) {
      return SizedBox(
        height: 34,
        child: Center(
          child: SpinKitThreeBounce(
            color: AppColors.primaryColor,
            size: 34,
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  static getRoundBorder(
      {required Color cBoxBgColor,
      required Color cBorderColor,
      required double dRadius,
      required double dBorderWidth}) {
    return BoxDecoration(
      color: cBoxBgColor,
      borderRadius: BorderRadius.circular(dRadius),
      border: Border.all(
        width: dBorderWidth,
        color: cBorderColor,
      ),
    );
  }

  static getErrorImage(double mHeight, double mWidth) {
    return Image.asset('', height: mHeight, width: mWidth, fit: BoxFit.contain);
  }

  static getSetDataWithReturn(BuildContext context, ShowData mShowData,
      Widget showWidget, String onReturn) {
    Widget widgetM = Container();

    switch (mShowData) {
      case ShowData.showLoading:
        widgetM = Container(
          alignment: Alignment.center,
          child: AppViews.showLoading(),
        );
        break;

      case ShowData.showData:
        widgetM = showWidget;

        break;
      case ShowData.showNoDataFound:
        widgetM = Center(
          child: Text(
            onReturn,
            textAlign: TextAlign.center,
          ),
        );

        break;
      case ShowData.showError:
        widgetM = const Text('Error');
        break;
    }

    return widgetM;
  }

  static getBorderDecor() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.2)),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  static showCustomAlert(
      {required BuildContext context,
      required String strTitle,
      required String strMessage,
      String? strLeftBtnText,
      String? strRightBtnText,
      Function? onTapLeftBtn,
      Function? onTapRightBtn}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strTitle,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            strMessage,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Global.checkNull(strLeftBtnText)
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                AppColors.colorWhite,
                                            disabledForegroundColor:
                                                AppColors.primaryColor,
                                            backgroundColor:
                                                AppColors.primaryColor),
                                        onPressed: () {
                                          if (onTapLeftBtn != null) {
                                            onTapLeftBtn();
                                          } else {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text(
                                          strLeftBtnText!,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                                const SizedBox(
                                  height: 0,
                                  width: 10,
                                ),
                                Global.checkNull(strRightBtnText)
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                AppColors.colorWhite,
                                            disabledForegroundColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.38),
                                            backgroundColor:
                                                AppColors.primaryColor),
                                        onPressed: () {
                                          if (onTapRightBtn != null) {
                                            onTapRightBtn();
                                          } else {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text(
                                          strRightBtnText!,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  static getGradientBoxDecoration({double? mBorderRadius}) {
    return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor,
            AppColors.orangeColor,
          ],
        ),
        borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getGreyGradientBoxDecoration({double? mBorderRadius}) {
    return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor,
            AppColors.orangeColor,
          ],
        ),
        borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getGrayDecoration({double? mBorderRadius}) {
    return BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getColorDecor({double? mBorderRadius, required Color mColor}) {
    return BoxDecoration(
        color: mColor, borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getRoundBorderDecor({double? mBorderRadius, required Color mColor}) {
    return BoxDecoration(
        border: Border.all(color: mColor),
        borderRadius: BorderRadius.circular(mBorderRadius ?? 6));
  }

  static textFieldGrayRoundBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.grey,
        style: BorderStyle.none,
      ),
    );
  }

  static textFieldRoundBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    );
  }
}
