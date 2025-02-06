import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfflinPage extends StatelessWidget {
  const OfflinPage({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.3,
          ),
          Text(
            'لايوجد اتصال بالإنترنت',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(12.r)),
                height: 50.h,
                width: 250.w,
                child: const Center(
                    child: Text(
                  'إعادة التحميل',
                  style: TextStyle(color: Colors.white),
                )),
              )),
        ],
      ),
    );
  }
}
