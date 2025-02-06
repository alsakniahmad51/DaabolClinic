import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderTableOrdersTodayCell extends StatelessWidget {
  const HeaderTableOrdersTodayCell({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 90.w,
      decoration: const BoxDecoration(color: Color(0xffE4F3E5)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
