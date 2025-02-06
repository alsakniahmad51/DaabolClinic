import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleListTile extends StatelessWidget {
  const TitleListTile({
    super.key,
    required this.data,
    required this.time,
  });

  final Order data;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.patientName,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        Text(
          data.detail!.type.typeName,
          style: TextStyle(
              fontSize: 13.sp, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        SizedBox(
          height: 3.h,
        ),
        Text(
          time,
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.primaryColor),
        )
      ],
    );
  }
}
