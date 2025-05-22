import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/theming/colors.dart';

class LogoCardWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const LogoCardWidget({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.r),
      elevation: 5,
      shadowColor: ColorsManager.lightSecondary,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 35.h,
        ),
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Theme.of(context).colorScheme.surface),
        child: Image.asset(ImageAssets.logo, fit: BoxFit.contain),
      ),
    );
  }
}
