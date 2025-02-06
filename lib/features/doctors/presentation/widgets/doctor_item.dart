// ignore_for_file: deprecated_member_use

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/functions/navigator.dart';
import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/doctors/presentation/pages/doctor_detailes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, right: 10.w, left: 10.w),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: InkWell(
          onTap: () {
            Moving.navToPage(
                context: context,
                page: DoctorDetails(
                  doctor: doctor,
                ));
          },
          child: SizedBox(
            height: 80.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,

                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Card(
                color: Colors.black12,
                child: ListTile(
                  trailing: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(top: 7.h),
                    child: Text(
                      doctor.name,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: SvgPicture.asset(
                      person,
                      height: 44.h,
                      width: 44.w,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
