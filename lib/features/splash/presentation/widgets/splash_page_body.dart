import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreenViewBody extends StatelessWidget {
  const SplashScreenViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              logo,
              height: 200.h,
              width: 500.w,
            ),
          ),
          Text(
            "مركز دعبول للأشعة",
            style: TextStyle(fontSize: 30.sp),
          )
        ],
      ),
    );
  }
}
