import 'package:clinic/features/home/domain/Entities/examination_option.dart';
import 'package:clinic/features/home/domain/Entities/examination_type.dart';
import 'package:clinic/features/home/domain/Entities/examonation_mode.dart';

class ExaminationDetail {
  final int detailId;
  final ExaminationMode mode;
  final ExaminationOption option;
  final ExaminationType type;
  ExaminationDetail({
    required this.detailId,
    required this.mode,
    required this.option,
    required this.type,
  });

  factory ExaminationDetail.fromJson(Map<String, dynamic> json) {
    return ExaminationDetail(
      detailId: json['detail_id'] ?? 0,
      mode: ExaminationMode.fromJson(json['mode']),
      option: ExaminationOption.fromJson(json['option']),
      type: ExaminationType.fromJson(json['type']),
    );
  }
}
