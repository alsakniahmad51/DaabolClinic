import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/doctors/presentation/pages/doctor_info_page.dart';
import 'package:clinic/features/doctors/presentation/pages/orders_doctor_history_page.dart';
import 'package:flutter/material.dart';

class DoctorDetailesBody extends StatelessWidget {
  const DoctorDetailesBody({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        DoctorInfo(
          doctor: doctor,
        ),
        DoctorOrdersHistory(
          doctorId: doctor.id,
          doctorName: doctor.name,
        ),
      ],
    );
  }
}
