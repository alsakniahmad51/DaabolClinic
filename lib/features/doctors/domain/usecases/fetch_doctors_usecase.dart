import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/doctors/domain/repos/doctor_repo.dart';

class FetchAllDoctorsUseCase {
  final DoctorRepository repository;

  FetchAllDoctorsUseCase(this.repository);

  Future<List<Doctor>> call() async {
    return await repository.getAllDoctors();
  }
}
