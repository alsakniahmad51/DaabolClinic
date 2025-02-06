class ExaminationType {
  final int examinationTypeId;
  final String typeName;

  ExaminationType({required this.examinationTypeId, required this.typeName});

  factory ExaminationType.fromJson(Map<String, dynamic> json) {
    return ExaminationType(
      examinationTypeId: json['examination_type_id'], // يمكن أن يكون null
      typeName: json['type_name'] ?? "غير معروف",
    );
  }
}
