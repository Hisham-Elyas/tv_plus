import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String? title;
  const CustomAppBar({super.key, this.actions, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      centerTitle: true,
      elevation: 0,
      shadowColor: Theme.of(context).colorScheme.surface.withOpacity(0.1),
      foregroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      forceMaterialTransparency: true,
      title: title != null
          ? Text(title!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold))
          // : LogoCardWidget(width: 150.w, height: 53.h),
          : Container(
              padding: EdgeInsets.symmetric(
                horizontal: 35.h,
              ),
              width: 250.h,
              height: 20.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).colorScheme.surface),
              child: Image.asset(ImageAssets.logo, fit: BoxFit.contain),
            ),
      iconTheme: IconThemeData(
        color: Theme.of(context)
            .colorScheme
            .onSurface, // Change this to your desired color
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 70.h);
}
