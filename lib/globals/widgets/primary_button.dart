import 'package:flutter/material.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

// All rights reserved by Healer
class CustomButton extends StatelessWidget {
  final String label;
  final Color? color;
  final GestureTapCallback onPress;
  final dynamic icon;
  final dynamic keys;
  final double buttonHight;
  final double radius;
  final double elevation;
  final bool enable;
  final dynamic textColor;
  final double textSize;
  final Color? buttonColor;

  const CustomButton(
      {Key? key,
      required this.label,
      required this.onPress,
      this.color,
      this.radius = 8,
      this.enable = true,
      this.icon,
      this.keys,
      this.buttonHight = 55.0,
      this.textSize = 17.0,
      this.buttonColor,
      this.elevation = 0,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 6),
      height: buttonHight,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: enable
              ? buttonColor ?? AppColors.primaryColor
              : AppColors.textGrey),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: enable ? onPress : () {},
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  return states.contains(MaterialState.pressed)
                      ? Colors.grey.shade400
                      : null;
                },
              ),
              elevation: MaterialStateProperty.all(elevation),
              backgroundColor:
                  MaterialStateProperty.all(color ?? AppColors.colorWhite),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
              )),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label.toUpperCase(),
              style: headingText(size: textSize).copyWith(
                  color: enable
                      ? textColor ?? AppColors.primaryColor
                      : AppColors.textGrey),
            ),
          ),
        ),
      ));
}

class RoundButton extends StatelessWidget {
  final double size;
  final Widget child;
  final Color? color;
  final double padding;
  final GestureTapCallback onTap;
  const RoundButton(
      {super.key,
      this.size = 30,
      required this.child,
      this.padding = 0,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ContainerProperties.simpleDecoration(
            radius: 100, color: color ?? AppColors.sparkblue),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: ContainerProperties.simpleDecoration(
              radius: 100, color: AppColors.colorWhite),
          margin: const EdgeInsets.only(top: 3, left: 3, right: 3, bottom: 6.8),
          height: size,
          width: size,
          child: child,
        ),
      ),
    );
  }
}
