import 'package:easy_puzzle_game/src/dashatar/widgets/colors.dart';
import 'package:flutter/material.dart';

TextStyle headingText({double size = 16, Color? color}) {
  return TextStyle(
      color: color ?? AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: size);
}

TextStyle subHeadingText({double size = 16, Color? color}) {
  return TextStyle(
      color: color ?? AppColors.primaryColor,
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
