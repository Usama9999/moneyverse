import 'package:flutter/material.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

showCustomAlert(
    {required BuildContext context,
    required String strTitle,
    required String strMessage,
    String? strLeftBtnText,
    String? strRightBtnText,
    Function? onTapLeftBtn,
    Function? onTapRightBtn}) {
  return showGeneralDialog(
      context: context,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
                          style: subHeadingText(),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          strMessage,
                          style: normalText(),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              strLeftBtnText!.isNotEmpty
                                  ? TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: AppColors.sparkblue,
                                          disabledForegroundColor:
                                              AppColors.sparkblue,
                                          backgroundColor: AppColors.sparkblue),
                                      onPressed: () {
                                        if (onTapLeftBtn != null) {
                                          onTapLeftBtn();
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(strLeftBtnText,
                                          style: subHeadingText(
                                              color: Colors.white)),
                                    )
                                  : const SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                              const SizedBox(
                                height: 0,
                                width: 10,
                              ),
                              strRightBtnText!.isNotEmpty
                                  ? TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: AppColors.sparkblue,
                                          disabledForegroundColor: AppColors
                                              .colorAccent
                                              .withOpacity(0.38),
                                          backgroundColor: AppColors.sparkblue),
                                      onPressed: () {
                                        if (onTapRightBtn != null) {
                                          onTapRightBtn();
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(strRightBtnText,
                                          style: subHeadingText(
                                              color: Colors.white)),
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
