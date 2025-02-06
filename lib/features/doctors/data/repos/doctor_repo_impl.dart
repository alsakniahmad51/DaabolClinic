import 'package:clinic/features/doctors/data/datasources/remote_doctor_datasource.dart';
import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/doctors/domain/repos/doctor_repo.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Doctor>> getAllDoctors() async {
    return await remoteDataSource.fetchAllDoctors();
  }

  @override
  Future<List<Order>> getDoctorOrders(
      int doctorId, DateTime startDate, DateTime endDate) async {
    return await remoteDataSource.fetchDoctorOrders(
        doctorId, startDate, endDate);
  }
}



// class DoctorRepositoryImpl implements DoctorRepository {
//   final DoctorRemoteDataSource remoteDataSource;

//   DoctorRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<List<Doctor>> getAllDoctors() async {
//     return await remoteDataSource.fetchAllDoctors();
//   }

//   @override
//   Future<List<Order>> getDoctorOrders(int doctorId) async {
//     return await remoteDataSource.fetchDoctorOrders(doctorId);
//   }
// }
