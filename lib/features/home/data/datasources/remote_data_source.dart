import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';

class RemoteDataSource {
  final SupabaseClient supabase;

  RemoteDataSource(this.supabase);

  /// Fetch orders by date range (e.g., month start to end)
  Future<List<Order>> fetchAllOrders(
      DateTime startDate, DateTime endDate) async {
    try {
      final response = await supabase
          .from('orders')
          .select('''
          order_id,
          doctor_id,
          patient_id,
          isImaged,
          date,
          image_extention,
          additional_notes,
          tooth_number,
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
          .gte('date', startDate.toIso8601String()) // تاريخ البداية
          .lte('date', endDate.toIso8601String()); // تاريخ النهاية

      final List<dynamic> data = response as List<dynamic>;

      return data.map((item) => Order.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load orders: ${e.toString()}');
    }
  }

  Future<void> updateOrderPrice(int orderId, int newPrice) async {
    try {
      // ignore: unused_local_variable
      final response = await supabase
          .from('orders')
          .update({'order_price': newPrice}).eq('order_id', orderId);
    } catch (e) {
      throw Exception('فشل في تحديث السعر: ${e.toString()}');
    }
  }

  Future<void> updateOrderState(int orderId) async {
    try {
      // ignore: unused_local_variable
      final response = await supabase
          .from('orders')
          .update({'isImaged': true}).eq('order_id', orderId);
    } catch (e) {
      throw Exception('فشل في تحديث الحالة: ${e.toString()}');
    }
  }

  Future<Map<int, String>> fetchDoctorNames(Set<int> doctorIds) async {
    try {
      final doctorIdsString = doctorIds.join(', ');
      final response = await supabase
          .from('doctors')
          .select('doctor_id, doctor_name')
          .filter('doctor_id', 'in', '($doctorIdsString)');

      return {for (var doc in response) doc['doctor_id']: doc['doctor_name']};
    } catch (e) {
      throw Exception('Failed to load doctor names: ${e.toString()}');
    }
  }
}
