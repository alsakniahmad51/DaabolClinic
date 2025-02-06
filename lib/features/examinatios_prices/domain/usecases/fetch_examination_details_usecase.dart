import 'package:clinic/features/examinatios_prices/domain/repo/examination_repository.dart';
import 'package:clinic/features/home/domain/Entities/examination_detail.dart';

class FetchExaminationDetailsUseCase {
  final ExaminationRepository repository;

  FetchExaminationDetailsUseCase(this.repository);

  Future<List<ExaminationDetail>> call() async {
    return await repository.fetchExaminationDetails();
  }
}
