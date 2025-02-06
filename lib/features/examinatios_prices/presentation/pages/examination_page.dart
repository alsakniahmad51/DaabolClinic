import 'package:clinic/features/examinatios_prices/presentation/widgets/examination_page_body.dart';
import 'package:flutter/material.dart';

class ExaminationPage extends StatelessWidget {
  const ExaminationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: const Text('قائمة الأسعار')),
        body: const ExaminationPageBody(),
      ),
    );
  }
}
