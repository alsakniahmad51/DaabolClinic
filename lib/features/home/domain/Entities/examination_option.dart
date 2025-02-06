class ExaminationOption {
  final int optionId;
  final String optionName;

  ExaminationOption({required this.optionId, required this.optionName});

  factory ExaminationOption.fromJson(Map<String, dynamic> json) {
    return ExaminationOption(
      optionId: json['option_id'], // يمكن أن يكون null
      optionName: json['option_name'] ?? "غير معروف",
    );
  }
}
