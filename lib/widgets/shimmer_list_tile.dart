import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({
    super.key,
    this.hasImage = false,
  });

  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 1.w),
      // padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.w),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5),
          ]),
      height: 13.h,
      child: Row(
        children: [
          if (hasImage)
            Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: shimerContainer(13.h, 13.h)),
          Expanded(
            child: Column(
              children: [
                shimerContainer(
                  5.h,
                ),
                const Spacer(),
                shimerContainer(
                  2.h,
                ),
                const Spacer(),
                shimerContainer(
                  2.h,
                ),
                const Spacer(),
                shimerContainer(
                  2.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget shimerContainer(double height, [double? width]) {
    return Shimmer.fromColors(
        baseColor: const Color(0xffedecf6),
        highlightColor: Colors.white,
        child: Container(
          height: height,
          width: width ?? double.maxFinite,
          color: Colors.white,
        ));
  }
}
