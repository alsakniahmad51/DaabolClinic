// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';

class MaitenenceDialog extends StatelessWidget {
  const MaitenenceDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'التطبيق في حالة صيانة',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            maintenenceIcon, // ضع المسار الصحيح للصورة
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            'نحن نقوم ببعض التحسينات. يرجى المحاولة لاحقًا.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إغلاق الـ AlertDialog
            Future.delayed(Duration.zero, () => exit(0)); // الخروج من التطبيق
          },
          child: const Text('خروج',
              style: TextStyle(color: AppColor.primaryColor)),
        ),
      ],
    );
  }
}
