import 'package:clinic/features/splash/data/data_sources/remote/get_version_remote.dart';
import 'package:clinic/features/splash/domain/repo/get_version_repo.dart';

class GetVersionRepoImpl extends GetVersionRepo {
  final GetRemoteVersion getRemoteVersionC;

  GetVersionRepoImpl({required this.getRemoteVersionC});
  @override
  Future<Map<String, dynamic>> getRemoteVersion() async {
    return getRemoteVersionC.getRemoteVersion();
  }
}
