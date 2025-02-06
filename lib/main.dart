import 'package:clinic/clinic_app.dart';
import 'package:clinic/core/util/supabase_keys.dart';
import 'package:clinic/features/doctors/data/datasources/remote_doctor_datasource.dart';
import 'package:clinic/features/doctors/data/repos/doctor_repo_impl.dart';
import 'package:clinic/features/doctors/domain/usecases/fetch_doctor_orders.dart';
import 'package:clinic/features/doctors/domain/usecases/fetch_doctors_usecase.dart';
import 'package:clinic/features/examinatios_prices/data/datasources/remote/remote_data_source.dart';
import 'package:clinic/features/examinatios_prices/data/repo/examination_repository_impl.dart';
import 'package:clinic/features/examinatios_prices/domain/usecases/fetch_examination_details_usecase.dart';
import 'package:clinic/features/examinatios_prices/domain/usecases/fetch_output_uscase.dart';
import 'package:clinic/features/examinatios_prices/domain/usecases/fetch_prices_usecase.dart';
import 'package:clinic/features/examinatios_prices/domain/usecases/update_output_price_usecase.dart';
import 'package:clinic/features/examinatios_prices/domain/usecases/update_price_usecase.dart';
import 'package:clinic/features/home/data/datasources/remote_data_source.dart';
import 'package:clinic/features/home/data/repos/data_repo_impl.dart';
import 'package:clinic/features/home/domain/usecase/fetch_order_usecase.dart';
import 'package:clinic/features/splash/data/data_sources/remote/get_version_remote.dart';
import 'package:clinic/features/splash/data/repo/get_version_repo_impl.dart';
import 'package:clinic/features/splash/domain/usecase/get_remote_version_usecase.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: SupabaseKeys.projectUrl,
    anonKey: SupabaseKeys.anonyKey,
  );
  ExaminationRemoteDataSource examinationRemoteDataSource =
      ExaminationRemoteDataSource(supabase.client);
  ExaminationRepositoryImpl examinationRepositoryImpl =
      ExaminationRepositoryImpl(examinationRemoteDataSource);
  RemoteDataSource remoteDataSource = RemoteDataSource(supabase.client);
  DataRepositoryImpl dataRepositoryImpl = DataRepositoryImpl(remoteDataSource);
  FetchOrdersUseCase fetchOrdersUseCase =
      FetchOrdersUseCase(dataRepositoryImpl);
  DoctorRemoteDataSource doctorRemoteDataSource =
      DoctorRemoteDataSource(supabase.client);
  DoctorRepositoryImpl doctorRepositoryImpl = DoctorRepositoryImpl(
    doctorRemoteDataSource,
  );

  FetchAllDoctorsUseCase fetchAllDoctorsUseCase = FetchAllDoctorsUseCase(
    doctorRepositoryImpl,
  );
  FetchDoctorOrdersUseCase fetchDoctorOrdersUseCase = FetchDoctorOrdersUseCase(
    doctorRepositoryImpl,
  );
  FetchExaminationDetailsUseCase fetchExaminationDetailsUseCase =
      FetchExaminationDetailsUseCase(examinationRepositoryImpl);
  UpdatePriceUseCase updatePriceUseCase = UpdatePriceUseCase(
    examinationRepositoryImpl,
  );
  FetchOutputDetailsUseCase fetchOutputDetailsUseCase =
      FetchOutputDetailsUseCase(
    examinationRepositoryImpl,
  );
  UpdateOutputPriceUseCase updateOutputPriceUseCase = UpdateOutputPriceUseCase(
    examinationRepositoryImpl,
  );
  GetRemoteVersion getRemoteVersion =
      GetRemoteVersion(supabaseClient: supabase.client);
  GetVersionRepoImpl getVersionRepoImpl = GetVersionRepoImpl(
    getRemoteVersionC: getRemoteVersion,
  );
  FetchPricesUsecase fetchPricesUsecase =
      FetchPricesUsecase(examinationRepository: examinationRepositoryImpl);
  GetRemoteVersionUsecase getRemoteVersionUsecase = GetRemoteVersionUsecase(
    getVersionRepoImpl: getVersionRepoImpl,
  );
  ClinicApp cliniApp = ClinicApp(
    fetchExaminationDetailsUseCase: fetchExaminationDetailsUseCase,
    fetchOrdersUseCase: fetchOrdersUseCase,
    fetchAllDoctorsUseCase: fetchAllDoctorsUseCase,
    fetchDoctorOrdersUseCase: fetchDoctorOrdersUseCase,
    updatePriceUseCase: updatePriceUseCase,
    fetchOutputDetailsUseCase: fetchOutputDetailsUseCase,
    updateOutputPriceUseCase: updateOutputPriceUseCase,
    getRemoteVersionUsecase: getRemoteVersionUsecase,
    fetchPricesUsecase: fetchPricesUsecase,
  );
  runApp(cliniApp);
}
