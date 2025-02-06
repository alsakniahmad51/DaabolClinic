import 'package:clinic/features/examinatios_prices/domain/repo/examination_repository.dart';

class UpdateOutputPriceUseCase {
  final ExaminationRepository repository;

  UpdateOutputPriceUseCase(this.repository);

  Future<void> call(int id, int newPrice) async {
    await repository.updateOutputPrice(id, newPrice);
  }
}
