import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final Widget child;
  MyShimmer({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[400],
        enabled: true,
        direction: ShimmerDirection.ltr,
        period: Duration(milliseconds: 3000),
        child: child);
  }
}
