import 'package:clinic/features/examinatios_prices/domain/Entities/prices.dart';
import 'package:clinic/features/home/domain/Entities/examination_detail.dart';
import 'package:clinic/features/home/domain/Entities/output.dart';

abstract class ExaminationRepository {
  Future<List<ExaminationDetail>> fetchExaminationDetails();
  Future<void> updatePrice(int priceId, int newPrice);
  Future<List<Output>> fetchOutputDetails();
  Future<void> updateOutputPrice(int id, int newPrice);
  Future<List<Prices>> fetchPrices();
}
