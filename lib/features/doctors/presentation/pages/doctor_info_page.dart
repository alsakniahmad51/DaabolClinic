// ignore_for_file: deprecated_member_use

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/doctors/presentation/widgets/custom_doctor_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 350.h, top: 20.h),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 18.w, top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDoctorInfo(
                title: 'الاسم',
                value: doctor.name,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h, right: 65.w, bottom: 25.h),
                child: SvgPicture.asset(
                  line,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDoctorInfo(
                    title: 'رقم الهاتف',
                    value: doctor.phoneNumber,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            _launchPhone('tel:${doctor.phoneNumber}'),
                        icon: const Icon(Icons.phone),
                        color: AppColor.primaryColor,
                      ),
                      IconButton(
                        onPressed: () => _launchWhatsApp(doctor.phoneNumber),
                        icon: const Icon(FontAwesomeIcons.whatsapp),
                        color: AppColor.primaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchPhone(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchWhatsApp(String phoneNumber) async {
  if (!phoneNumber.startsWith('+')) {
    phoneNumber = '+963$phoneNumber';
  }
  final url = 'https://wa.me/$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
