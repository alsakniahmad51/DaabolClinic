import 'package:clinic/features/home/domain/Entities/examination_detail.dart';
import 'package:clinic/features/home/domain/Entities/output.dart';

class Order {
  final int? toothNumber;
  final int id;
  final int doctorId;
  final int imageExtention;
  final int patientId;
  final bool isImaged;
  String patientName;
  String doctorName;
  final DateTime date;
  int patientAge;
  String? phoneNumber;
  final ExaminationDetail? detail;
  final String? additionalNotes;
  final int price;
  final Output? output;
  Order(
    this.toothNumber,
    this.isImaged, {
    required this.imageExtention,
    required this.output,
    required this.id,
    required this.doctorId,
    required this.patientId,
    this.patientName = 'غير معروف',
    this.doctorName = 'غير معروف',
    required this.date,
    this.patientAge = 0,
    this.phoneNumber,
    this.detail,
    this.additionalNotes,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      json['tooth_number'],
      json['isImaged'],
      id: json['order_id'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
      patientId: json['patient_id'] ?? 0,
      patientName: json['patients']?['patient_name'] ?? 'غير معروف',
      doctorName: json['doctors']?['doctor_name'] ?? 'غير معروف',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      patientAge: json['patients']?['age'] ?? 0,
      phoneNumber: json['patients']?['phone_number'],
      detail: ExaminationDetail.fromJson(json['examinationdetails']),
      additionalNotes: json['additional_notes'] ?? 'لا يوجد',
      price: json['order_price'] ?? 0,
      output: Output.fromjson(json['output']),
      imageExtention: json['image_extention'],
    );
  }
}
