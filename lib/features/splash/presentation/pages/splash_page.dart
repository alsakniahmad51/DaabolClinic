// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:clinic/features/home/presentation/pages/page_view.dart';
import 'package:clinic/features/splash/data/data_sources/local/get_app_version_local.dart';
import 'package:clinic/features/splash/presentation/manager/cubit/get_remote_version_cubit.dart';
import 'package:clinic/features/splash/presentation/widgets/error_alert_dialog.dart';
import 'package:clinic/features/splash/presentation/widgets/maitenence_dialog.dart';
import 'package:clinic/features/splash/presentation/widgets/splash_page_body.dart';
import 'package:clinic/features/splash/presentation/widgets/update_version_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetRemoteVersionCubit>(context).getRemoteVersion();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetRemoteVersionCubit, GetRemoteVersionState>(
      listener: (context, state) async {
        {
          if (state is GetRemoteVersionSucsess) {
            final localVersion = await getAppVersion();
            log(localVersion);
            final remoteVersion = state.version['version'];
            log(remoteVersion);
            if (remoteVersion == localVersion) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Pageview()));
            } else if (remoteVersion == '0.0.0') {
              showDialog(
                context: context,
                builder: (context) => const MaitenenceDialog(),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => UpdateVersionAlertDialog(
                  version: state.version,
                ),
              );
            }
          }
        }
        if (state is GetRemoteVersionFailure) {
          showDialog(
            context: context,
            builder: (context) => ErrorAlertDialog(
              errMessage: state.errMessage,
            ),
          );
        }
      },
      child: const SplashScreenViewBody(),
    );
  }
}
