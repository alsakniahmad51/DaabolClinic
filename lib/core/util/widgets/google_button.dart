import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 44.h,
      decoration: BoxDecoration(
          color: const Color(0xffE4f3E5),
          borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        children: [
          SizedBox(
            width: 75.w,
          ),
          Text(
            "أنشئ حساب بواسطة جوجل  ",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Cairo",
                fontSize: 17.sp,
                fontWeight: FontWeight.w400),
          ),
          SvgPicture.asset('assets/images/google.svg')
        ],
      ),
    );
  }
}
