import 'package:flutter/material.dart';
import 'package:talentogram/globals/container_properties.dart';

import '../../utils/app_colors.dart';

class ThreeDotIcon extends StatelessWidget {
  final Function onTap;
  const ThreeDotIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 30,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: 7,
              padding: const EdgeInsets.all(1.5),
              decoration: ContainerProperties.borderDecoration(
                  borderColor: AppColors.primaryColor, width: 1.8),
            ),
            Container(
              width: 7,
              padding: const EdgeInsets.all(1.5),
              decoration: ContainerProperties.borderDecoration(
                  borderColor: AppColors.primaryColor, width: 1.8),
            ),
            Container(
              width: 7,
              padding: const EdgeInsets.all(1.5),
              decoration: ContainerProperties.borderDecoration(
                  borderColor: AppColors.primaryColor, width: 1.8),
            ),
          ],
        ),
      ),
    );
  }
}
