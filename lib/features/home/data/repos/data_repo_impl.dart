import 'package:clinic/features/home/data/datasources/remote_data_source.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/domain/repos/data_repo.dart';

class DataRepositoryImpl implements DataRepository {
  final RemoteDataSource remoteDataSource;

  DataRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Order>> fetchAllOrders(
      DateTime startDate, DateTime endDate) async {
    return await remoteDataSource.fetchAllOrders(startDate, endDate);
  }

  @override
  Future<Map<int, String>> fetchDoctorNames(Set<int> doctorIds) async {
    return await remoteDataSource.fetchDoctorNames(doctorIds);
  }

  @override
  Future<void> updateOrderPrice(int orderId, int newPrice) async {
    return await remoteDataSource.updateOrderPrice(orderId, newPrice);
  }

  @override
  Future<void> updateOrderState(int orderId) async {
    return await remoteDataSource.updateOrderState(orderId);
  }
}
