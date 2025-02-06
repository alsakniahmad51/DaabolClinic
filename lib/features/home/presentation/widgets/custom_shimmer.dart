import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0), // عكس الاتجاه
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 35.h,
              color: Colors.grey[850],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(-1.0, 1.0, 1.0), // عكس الاتجاه مرة أخرى
                    child: Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          color: Colors.grey[850],
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 16.h,
                                color: Colors.grey[850],
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 14.h,
                                color: Colors.grey[850],
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 12.h,
                                color: Colors.grey[850],
                              ),
                              SizedBox(height: 45.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
