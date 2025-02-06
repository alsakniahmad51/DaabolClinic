import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightRowItem extends StatelessWidget {
  const RightRowItem({
    super.key,
    required this.child,
    this.topRadius,
    this.bottomRadius,
  });
  final Widget? child;
  final double? topRadius;
  final double? bottomRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColor.secondColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRadius ?? 0),
            bottomRight: Radius.circular(bottomRadius ?? 0)),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
