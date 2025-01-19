import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../data/models/channel_category_model.dart';

class CategoriesCardWidget extends StatelessWidget {
  const CategoriesCardWidget(
      {super.key, required this.category, required this.onTap});
  final void Function() onTap;
  final ChannelCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10.r),
        elevation: 3,
        color: ColorsManager.white,
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
                  imageUrl: category.logo,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        color: ColorsManager.mainBlue,
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              verticalSpace(8),
              FittedBox(
                child: Text(
                  category.categoryName,
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
