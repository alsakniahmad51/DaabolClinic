import 'package:clinic/features/doctors/presentation/widgets/doctors_page_body.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DoctorsPageBody(),
    );
  }
}
