import 'package:clinic/features/examinatios_prices/domain/Entities/prices.dart';
import 'package:clinic/features/examinatios_prices/domain/repo/examination_repository.dart';

class FetchPricesUsecase {
  final ExaminationRepository examinationRepository;

  FetchPricesUsecase({required this.examinationRepository});
  Future<List<Prices>> call() async {
    return await examinationRepository.fetchPrices();
  }
}
