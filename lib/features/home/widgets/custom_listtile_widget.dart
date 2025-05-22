import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';

class CustomListTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData? icon;
  final Widget? trailing;
  final TextStyle? style;

  const CustomListTileWidget({
    super.key,
    this.onTap,
    required this.title,
    this.icon,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 10,
        shadowColor: ColorsManager.lightSecondary,
        child: ListTile(
          trailing: trailing,
          onTap: onTap,
          leading: icon == null
              ? null
              : Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
          title: Text(
            title,
            style: style ??
                TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ));
  }
}
