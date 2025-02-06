// ignore_for_file: use_build_context_synchronously

import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/widgets/table_item_order_detailes.dart';
import 'package:flutter/material.dart';

class DetailesTable extends StatelessWidget {
  const DetailesTable({
    super.key,
    required this.order,
    required this.date,
    required this.formattedTime,
  });

  final Order order;
  final String date;
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableItem(
          title: 'اسم المريض',
          value: order.patientName,
          topradius: 12,
          buttomradius: 0,
        ),
        TableItem(
          title: 'العمر',
          value: "${order.patientAge}",
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'رقم هاتف المريض',
          value: "${order.phoneNumber}",
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'اسم الطبيب',
          value: order.doctorName,
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'نوع الصورة',
          value: order.detail!.type.typeName,
          topradius: 0,
          buttomradius: 0,
        ),
        if (order.detail!.option.optionName != "لا يوجد")
          TableItem(
            title: 'الجزء المراد تصويره',
            value: order.detail!.option.optionName,
            topradius: 0,
            buttomradius: 0,
          ),
        if (order.detail!.option.optionName == 'ساحة 5*5 مميزة للبية')
          TableItem(
            title: 'رقم السن',
            value: order.toothNumber.toString(),
            topradius: 0,
            buttomradius: 0,
          ),
        if (order.detail!.mode.modeName != "لا يوجد")
          TableItem(
            title: 'وضعية الصورة',
            value: order.detail!.mode.modeName,
            topradius: 0,
            buttomradius: 0,
          ),
        if (order.detail!.type.typeName != "C.B.C.T")
          TableItem(
            title: 'شكل الصورة',
            value: order.output!.type,
            topradius: 0,
            buttomradius: 0,
          ),
        TableItem(
          title: 'التاريخ',
          value: date,
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'التوقيت',
          value: formattedTime,
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'قيمة الفاتورة',
          value: "${order.price} ل.س",
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'ملاحظات',
          value: order.additionalNotes ?? "",
          topradius: 0,
          buttomradius: 12,
        ),
      ],
    );
  }
}
