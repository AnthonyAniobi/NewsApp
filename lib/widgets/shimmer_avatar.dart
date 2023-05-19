import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAvatar extends StatelessWidget {
  const ShimmerAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.h),
            child: shimerContainer(8.h, 8.h),
          ),
          SizedBox(height: 0.8.h),
          shimerContainer(2.h, 8.h),
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
