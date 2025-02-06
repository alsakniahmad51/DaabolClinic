import 'package:clinic/features/home/domain/Entities/order.dart';

abstract class DataRepository {
  Future<List<Order>> fetchAllOrders(DateTime startDate, DateTime endDate);
  Future<Map<int, String>> fetchDoctorNames(
      Set<int> doctorIds); // جلب أسماء الأطباء دفعة واحدة
  Future<void> updateOrderPrice(int orderId, int newPrice);
  Future<void> updateOrderState(int orderId);
}
