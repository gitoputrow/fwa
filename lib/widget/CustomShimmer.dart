import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double marginHorizontal;
  final double borderRadius;
  const CustomShimmer({super.key, required this.height, this.width = double.infinity, this.marginHorizontal = 0, this.borderRadius = 16});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey.shade200.withOpacity(.5),
      highlightColor: Colors.grey.shade300.withOpacity(.8),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
