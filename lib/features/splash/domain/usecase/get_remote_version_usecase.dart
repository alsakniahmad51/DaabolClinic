import 'package:clinic/features/splash/data/repo/get_version_repo_impl.dart';

class GetRemoteVersionUsecase {
  final GetVersionRepoImpl getVersionRepoImpl;

  GetRemoteVersionUsecase({required this.getVersionRepoImpl});
  Future<Map<String, dynamic>> call() async {
    return await getVersionRepoImpl.getRemoteVersion();
  }
}
