import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorRemoteDataSource {
  final SupabaseClient supabase;

  DoctorRemoteDataSource(this.supabase);

  Future<List<Doctor>> fetchAllDoctors() async {
    final response = await supabase
        .from('doctors')
        .select('doctor_id, user_id, doctor_name, phone_number');

    final List<dynamic> data = response as List<dynamic>;
    return data.map((item) => Doctor.fromJson(item)).toList();
  }

  Future<List<Order>> fetchDoctorOrders(
      int doctorId, DateTime startDate, DateTime endDate) async {
    try {
      final response = await supabase
          .from('orders')
          .select('''
          order_id,
          doctor_id,
          tooth_number,
          isImaged,
          patient_id,
          date,
          additional_notes,
          order_price,
          order_output,
          patients(
            patient_id,
            patient_name,
            age,
            phone_number
          ),
          output:order_output(
          id,
          output_type,
          price
        ),
          examinationdetails!inner(
            detail_id,
                     mode:examinationmodes(mode_id, mode_name),
            option:examinationoptions(option_id, option_name),
            type:examinationtypes(examination_type_id, type_name)
          )
        ''')
          .eq('doctor_id', doctorId)
          .gte('date', startDate.toIso8601String()) // تاريخ البداية
          .lte('date', endDate.toIso8601String()); // تاريخ النهاية

      final List<dynamic> data = response as List<dynamic>;

      return data.map((item) => Order.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load orders: ${e.toString()}');
    }
  }
}
