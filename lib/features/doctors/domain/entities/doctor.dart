class Doctor {
  final int id;
  final String userId;
  final String name;
  final String phoneNumber;

  Doctor({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['doctor_id'] ?? 0,
      userId: json['user_id'] ?? '',
      name: json['doctor_name'] ?? 'غير معروف',
      phoneNumber: json['phone_number'] ?? 'غير معروف',
    );
  }
}
