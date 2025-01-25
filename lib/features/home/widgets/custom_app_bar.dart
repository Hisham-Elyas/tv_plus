import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../onboarding/widgets/logo_card_widget.dart';

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
          : LogoCardWidget(width: 150.w, height: 53.h),
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
