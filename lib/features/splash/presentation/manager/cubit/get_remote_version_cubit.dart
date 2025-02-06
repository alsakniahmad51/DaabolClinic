import 'package:clinic/features/splash/domain/usecase/get_remote_version_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_remote_version_state.dart';

class GetRemoteVersionCubit extends Cubit<GetRemoteVersionState> {
  GetRemoteVersionCubit(this.getRemoteVersionUsecase)
      : super(GetRemoteVersionInitial());
  final GetRemoteVersionUsecase getRemoteVersionUsecase;

  Future<Map?> getRemoteVersion() async {
    emit(GetRemoteVersionLoading());
    try {
      final version = await getRemoteVersionUsecase.call();
      emit(GetRemoteVersionSucsess(version: version));
      return version;
    } catch (e) {
      // تحديد الرسالة عند فقدان الاتصال
      if (e.toString().contains('SocketException')) {
        emit(const GetRemoteVersionFailure(
            errMessage: 'لا يوجد اتصال بالإنترنت.'));
      } else {
        emit(const GetRemoteVersionFailure(errMessage: 'حدث خطأ غير متوقع.'));
      }
      return null;
    }
  }
}
