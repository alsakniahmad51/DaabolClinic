// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:clinic/core/util/supabase_upload_service.dart';
import 'package:clinic/features/home/presentation/manager/update_state_order_cubit/update_state_order_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FileUploader {
  final BuildContext context;
  final String orderId;
  final Supabase supabase;

  late final SupabaseUploadService _uploadService;
  bool _isUploading = false;
  final ValueNotifier<double> _progressNotifier = ValueNotifier(0.0);

  FileUploader({
    required this.context,
    required this.orderId,
    required this.supabase,
  }) {
    _uploadService = SupabaseUploadService(supabase.client, 'images');
  }

  Future<void> pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['dcm', 'jpg', 'png', 'jpeg'],
    );

    if (result == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'تم إلغاء عملية الرفع',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    PlatformFile? pickedFile = result.files.firstOrNull;

    if (pickedFile == null || pickedFile.path == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'لم يتم اختيار ملف صالح',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    File file = File(pickedFile.path!);
    String fileName = "$orderId.${pickedFile.extension}";

    // إظهار Dialog تفاصيل الملف
    await _showFileDetailsDialog(pickedFile, file, fileName);
  }

  Future<void> _showFileDetailsDialog(
      PlatformFile pickedFile, File file, String fileName) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('تفاصيل الملف'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('اسم الملف: ${pickedFile.name}'),
                const SizedBox(height: 8),
                Text(
                    'حجم الملف: ${_formatFileSize(pickedFile.size)}'), // استخدام دالة التحويل
                const SizedBox(height: 8),
                Text('مسار الملف: ${pickedFile.path}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق Dialog التفاصيل
                },
                child: const Text('إلغاء'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق Dialog التفاصيل
                  _startUpload(file, fileName); // بدء عملية الرفع
                },
                child: const Text('رفع'),
              )
            ],
          ),
        );
      },
    );
  }

// دالة لتحويل حجم الملف إلى KB أو MB
  String _formatFileSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      // إذا كان الحجم أكبر من أو يساوي 1 ميجابايت
      double sizeInMB = bytes / (1024 * 1024);
      return '${sizeInMB.toStringAsFixed(2)} MB';
    } else {
      // إذا كان الحجم أقل من 1 ميجابايت
      double sizeInKB = bytes / 1024;
      return '${sizeInKB.toStringAsFixed(2)} KB';
    }
  }

  Future<void> _startUpload(File file, String fileName) async {
    try {
      _showUploadProgressDialog(); // إظهار Dialog التقدم

      _isUploading = true;

      final xFile = XFile(file.path);
      // ignore: avoid_print
      print('xFile path: ${xFile.path}'); // فحص مسار الملف

      await _uploadService.uploadFile(
        xFile,
        fileName: fileName,
        onUploadProgress: (progress) {
          _updateProgress(progress);
        },
      );
      String extention = fileName.split('.')[1];
      int extentionNumber = selectextentionNumber(extention);

      await supabase.client
          .from('orders')
          .update({'image_extention': extentionNumber}).eq(
              'order_id', int.parse(orderId));
      _isUploading = false;
      if (context.mounted) {
        Navigator.of(context).pop(); // إغلاق Dialog التقدم
      }
      if (context.mounted) {
        BlocProvider.of<UpdateStateOrderCubit>(context)
            .updateOrderState(int.parse(orderId));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم رفع الملف بنجاح: $fileName',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      _isUploading = false;
      if (context.mounted) {
        Navigator.of(context).pop(); // إغلاق Dialog التقدم
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'فشل رفع الملف: $error',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  int selectextentionNumber(String extention) {
    switch (extention) {
      case "jpg":
        return 1;

      case "png":
        return 2;

      case "jpeg":
        return 3;

      case "dcm":
        return 4;

      default:
        return 0;
    }
  }

  void _showUploadProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ValueListenableBuilder<double>(
          valueListenable: _progressNotifier,
          builder: (context, progress, _) {
            return AlertDialog(
              title: const Text('جاري رفع الملف...'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text('${(progress * 100).toStringAsFixed(1)}%'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: _isUploading ? () => _cancelUpload(context) : null,
                  child: const Text('إلغاء'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateProgress(double progress) {
    _progressNotifier.value = progress;
  }

  void _cancelUpload(BuildContext context) {
    _isUploading = false;
    Navigator.of(context).pop(); // إغلاق Dialog التقدم
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم إلغاء عملية الرفع',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
