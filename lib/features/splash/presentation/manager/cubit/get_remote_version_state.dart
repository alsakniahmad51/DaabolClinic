part of 'get_remote_version_cubit.dart';

sealed class GetRemoteVersionState extends Equatable {
  const GetRemoteVersionState();

  @override
  List<Object> get props => [];
}

final class GetRemoteVersionInitial extends GetRemoteVersionState {}

final class GetRemoteVersionFailure extends GetRemoteVersionState {
  final String errMessage;

  const GetRemoteVersionFailure({required this.errMessage});
}

final class GetRemoteVersionLoading extends GetRemoteVersionState {}

final class GetRemoteVersionSucsess extends GetRemoteVersionState {
  final Map<String, dynamic> version;

  const GetRemoteVersionSucsess({required this.version});
}
