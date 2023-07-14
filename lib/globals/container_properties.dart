import 'package:flutter/material.dart';
import 'package:talentogram/globals/extensions/color_extensions.dart';
import 'package:talentogram/utils/app_colors.dart';

class ContainerProperties {
  static BoxDecoration shadowDecoration(
      {double radius = 6.0,
      double blurRadius = 1.0,
      color,
      double opacity = 0.4}) {
    return BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(opacity),
              offset: const Offset(0, 2),
              blurRadius: blurRadius),
        ]);
  }

  static BoxDecoration simpleDecoration({double radius = 8.0, color}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static BoxDecoration roundDecoration({double radius = 8.0, color}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      shape: BoxShape.circle,
    );
  }

  static BoxDecoration textFieldDecoration({double radius = 4.0, color}) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: color ?? HexColor('#222B2F'),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static BoxDecoration borderDecoration(
      {double radius = 5.0, double width = 1.0, borderColor, color}) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: color ?? Colors.transparent,
      border: Border.all(
          color: borderColor ?? AppColors.paymentContainer, width: width),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static BoxDecoration borderDecorationShadow(
      {double radius = 5.0,
      double width = 1.0,
      borderColor,
      double blurRadius = 6.0}) {
    return BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: borderColor, width: width),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              offset: const Offset(0, 0),
              blurRadius: blurRadius),
        ]);
  }
}
