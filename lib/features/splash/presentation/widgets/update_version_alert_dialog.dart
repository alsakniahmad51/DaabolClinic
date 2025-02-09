// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateVersionAlertDialog extends StatelessWidget {
  const UpdateVersionAlertDialog({
    super.key,
    required this.version,
  });
  final Map<String, dynamic> version;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'إصدار جديد متوفر',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'يتوفر إصدار جديد من التطبيق. يرجى التحديث للحصول على أفضل تجربة.',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إغلاق الـ AlertDialog
            Future.delayed(Duration.zero, () => exit(0)); // الخروج من التطبيق
          },
          child: const Text(
            'خروج',
            style: TextStyle(color: AppColor.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () async {
            final url = version['link']; // رابط التحميل
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                  'تعذر فتح الرابط',
                  textDirection: TextDirection.rtl,
                )),
              );
            }
          },
          child: const Text('تحميل',
              style: TextStyle(color: AppColor.primaryColor)),
        ),
      ],
    );
  }
}
