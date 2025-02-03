import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../data/models/channel_category_model.dart';

class ChannelCardWidget extends StatelessWidget {
  const ChannelCardWidget({
    super.key,
    required this.channel,
    this.onTap,
  });
  final void Function()? onTap;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10.r),
        shadowColor: ColorsManager.lightSecondary,
        elevation: 6,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  width: 70.w,
                  height: 70.h,
                  fit: BoxFit.contain,
                  imageUrl: channel.logo,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Skeletonizer(
                    enableSwitchAnimation: true,
                    enabled: true,
                    child: Skeleton.shade(
                        child: Icon(Icons.live_tv_outlined, size: 60.dm)),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              verticalSpace(8),
              FittedBox(
                child: Text(
                  channel.name,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
