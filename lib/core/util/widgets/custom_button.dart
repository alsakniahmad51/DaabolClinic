

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.titleColor,
  });
  final String title;
  final Color color;
  final void Function()? onTap;
  final Color titleColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          
            color: color, borderRadius: BorderRadius.circular(5.r)),
        width: 361.w,
        height: 44.h,
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: titleColor),
        )),
      ),
    );
  }
}
