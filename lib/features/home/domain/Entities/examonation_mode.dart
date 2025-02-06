class ExaminationMode {
  final int modeId;
  final String modeName;

  ExaminationMode({required this.modeId, required this.modeName});

  factory ExaminationMode.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ExaminationMode(
        modeId: 0,
        modeName: 'غير معروف',
      );
    }
    return ExaminationMode(
      modeId: json['mode_id'] ?? 0,
      modeName: json['mode_name'] ?? 'غير معروف',
    );
  }
}
