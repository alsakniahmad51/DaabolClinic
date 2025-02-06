import 'package:bloc/bloc.dart';
import 'package:clinic/features/doctors/domain/entities/doctor.dart';
import 'package:clinic/features/doctors/domain/usecases/fetch_doctors_usecase.dart';
import 'package:equatable/equatable.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final FetchAllDoctorsUseCase getAllDoctorsUseCase;
  List<Doctor> allDoctors = [];
  List<Doctor> filteredDoctors = [];

  DoctorsCubit(this.getAllDoctorsUseCase) : super(DoctorsInitial());

  Future<void> fetchDoctors() async {
    emit(DoctorsLoading());
    try {
      final doctors = await getAllDoctorsUseCase();
      allDoctors = doctors;
      filteredDoctors = doctors;
      emit(DoctorsLoaded(filteredDoctors));
    } catch (e) {
      emit(DoctorsError('Failed to fetch doctors: $e'));
    }
  }

  void searchDoctors(String query) {
    filteredDoctors = allDoctors
        .where(
            (doctor) => doctor.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(DoctorsLoaded(filteredDoctors));
  }
}
