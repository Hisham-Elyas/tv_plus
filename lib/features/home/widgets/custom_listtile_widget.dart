import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';

class CustomListTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData icon;
  final Widget? trailing;

  const CustomListTileWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 10,
        shadowColor: ColorsManager.lightSecondary,
        child: ListTile(
          trailing: trailing,
          onTap: onTap,
          leading: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ));
  }
}
