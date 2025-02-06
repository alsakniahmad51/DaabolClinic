class Patient {
  final int id;
  final String name;
  final int age;
  final String? phoneNumber;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    this.phoneNumber,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json[
          'patient_id'], // استبدل patient_id بالاسم الصحيح في جدول Supabase
      name: json['patient_name'], // استبدل patient_name بالاسم الصحيح
      age: json['age'], // استبدل age بالاسم الصحيح
      phoneNumber: json['phone_number'], // استبدل phone_number بالاسم الصحيح
    );
  }
}
