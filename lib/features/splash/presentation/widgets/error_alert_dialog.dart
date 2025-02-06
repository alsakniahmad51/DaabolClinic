// ignore_for_file: use_build_context_synchronously

import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    super.key,
    required this.errMessage,
  });
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('خطأ'),
      content: SizedBox(
        height: 150.h,
        child: Column(
          children: [
            errMessage == 'لا يوجد اتصال بالإنترنت.'
                ? Image.asset(offlineIcon)
                : const SizedBox(),
            SizedBox(
              height: 20.h,
            ),
            Text(errMessage),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('حسناً',
              style: TextStyle(color: AppColor.primaryColor)),
        ),
      ],
    );
  }
}
