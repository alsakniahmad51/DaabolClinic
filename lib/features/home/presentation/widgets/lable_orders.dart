import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LableOrders extends StatelessWidget {
  const LableOrders({
    super.key,
    required this.text,
    required this.padding,
    this.onTap,
  });
  final String text;
  final double padding;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onTap,
            child: Text(
              '< عرض الكل',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.primaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.primaryColor),
            ),
          ),
          const Spacer(),
          Text(
            text,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
