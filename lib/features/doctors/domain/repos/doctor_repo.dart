import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';

abstract class DoctorRepository {
  Future<List<Doctor>> getAllDoctors();
  Future<List<Order>> getDoctorOrders(
      int doctorId, DateTime startDate, DateTime endDate);
}
