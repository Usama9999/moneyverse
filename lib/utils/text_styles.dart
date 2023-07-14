import 'package:flutter/material.dart';
import 'package:talentogram/utils/app_colors.dart';

TextStyle headingText({double size = 16, Color? color}) {
  return TextStyle(
      color: color ?? AppColors.primaryColor,
      fontWeight: FontWeight.w600,
      fontSize: size);
}

TextStyle subHeadingText({double size = 16, Color? color}) {
  return TextStyle(
      color: color ?? AppColors.textGrey,
      fontSize: size,
      fontWeight: FontWeight.w600);
}

TextStyle regularText({double size = 14, Color? color}) {
  return TextStyle(
    color: color ?? AppColors.textColor,
    fontSize: size,
    fontWeight: FontWeight.w500,
  );
}

TextStyle normalText({double size = 14, Color? color}) {
  return TextStyle(
    color: color ?? AppColors.textColor,
    fontSize: size,
    fontWeight: FontWeight.normal,
  );
}

TextStyle underLineText({double size = 14, Color? color}) {
  return TextStyle(
      // fontFamily: "Roboto",
      color: color ?? AppColors.textColor,
      fontSize: size,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline);
}

TextStyle lightText({double size = 14, Color? color}) {
  return TextStyle(
    // fontFamily: "Roboto",
    color: AppColors.lightText,
    fontSize: size,
    fontWeight: FontWeight.normal,
  );
}
