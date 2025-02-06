import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 168.w,
          child: const Divider(
            color: Colors.black38,
            height: 4,
          ),
        ),
        const Text(
          "  أو  ",
          style: TextStyle(color: Color(0xff898A8F), fontFamily: "Cairo"),
        ),
        SizedBox(
          width: 168.w,
          child: const Divider(
            color: Colors.black38,
            height: 4,
          ),
        )
      ],
    );
  }
}
