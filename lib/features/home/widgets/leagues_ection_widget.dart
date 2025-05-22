import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../data/models/league_model.dart';
import 'match_card_widget.dart';

class LeagueSectionWidget extends StatelessWidget {
  final LeagueModel league;
  const LeagueSectionWidget({
    super.key,
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          shadowColor: ColorsManager.lightSecondary,
          // surfaceTintColor: Theme.of(context).colorScheme.secondary,
          elevation: 10,
          color: Theme.of(context).colorScheme.surface,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            child: Row(
              children: [
                if (league.leagueLogo.isNotEmpty)
                  CachedNetworkImage(
                    width: 15.w,
                    fit: BoxFit.contain,
                    imageUrl: league.leagueLogo,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Skeletonizer(
                      enableSwitchAnimation: true,
                      enabled: true,
                      child: SizedBox(
                        width: 25.w,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                horizontalSpace(15),
                Text(
                  league.league,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue,
                  ),
                ),
                horizontalSpace(15),
                Skeleton.shade(
                  child: Icon(Icons.emoji_events,
                      color: Colors.yellow.shade500, size: 15.dm),
                ),
              ],
            ),
          ),
        ),
        ...league.matches.map((match) => MatchCardWidget(event: match)),
      ],
    );
  }
}
