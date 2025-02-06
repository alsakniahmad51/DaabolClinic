import 'package:clinic/features/examinatios_prices/domain/repo/examination_repository.dart';
import 'package:clinic/features/home/domain/Entities/output.dart';

class FetchOutputDetailsUseCase {
  final ExaminationRepository repository;

  FetchOutputDetailsUseCase(this.repository);

  Future<List<Output>> call() async {
    return await repository.fetchOutputDetails();
  }
}
