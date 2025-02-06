import 'package:clinic/features/examinatios_prices/data/datasources/remote/remote_data_source.dart';
import 'package:clinic/features/examinatios_prices/domain/Entities/prices.dart';
import 'package:clinic/features/examinatios_prices/domain/repo/examination_repository.dart';
import 'package:clinic/features/home/domain/Entities/examination_detail.dart';
import 'package:clinic/features/home/domain/Entities/output.dart';

class ExaminationRepositoryImpl implements ExaminationRepository {
  final ExaminationRemoteDataSource remoteDataSource;

  ExaminationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ExaminationDetail>> fetchExaminationDetails() async {
    return await remoteDataSource.fetchExaminationDetails();
  }

  @override
  Future<void> updatePrice(int priceId, int newPrice) async {
    await remoteDataSource.updatePrice(priceId, newPrice);
  }

  @override
  Future<List<Output>> fetchOutputDetails() async {
    return await remoteDataSource.fetchOutputDetails();
  }

  @override
  Future<void> updateOutputPrice(int id, int newPrice) async {
    await remoteDataSource.updateOutputPrice(id, newPrice);
  }

  @override
  Future<List<Prices>> fetchPrices() async {
    return await remoteDataSource.fetchPrices();
  }
}
