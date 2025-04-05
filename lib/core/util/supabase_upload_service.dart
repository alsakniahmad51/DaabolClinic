// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUploadService {
  final SupabaseClient supabaseClient;
  final String bucketName;

  SupabaseUploadService(this.supabaseClient, this.bucketName);
  Future<void> uploadFile(
    XFile file, {
    required String fileName, // استقبال اسم الملف
    required Function(double) onUploadProgress,
  }) async {
    try {
      final fileBytes = await file.readAsBytes();

      // استخدم fileName الذي تم تمريره بدلاً من التسمية العشوائية
      final filePath = fileName;

      const chunkSize = 256 * 1024; // 256 KB
      int totalChunks = (fileBytes.length / chunkSize).ceil();
      int uploadedBytes = 0;

      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = (i + 1) * chunkSize;
        if (end > fileBytes.length) {
          end = fileBytes.length;
        }

        final chunk = fileBytes.sublist(start, end);
        await supabaseClient.storage
            .from(bucketName)
            .uploadBinary(filePath, chunk,
                fileOptions: FileOptions(
                  contentType: file.mimeType,
                  upsert: true,
                ));

        uploadedBytes += chunk.length;
        double progress = uploadedBytes / fileBytes.length;
        onUploadProgress(progress);
      }

      onUploadProgress(1.0);
    } catch (error) {
      rethrow;
    }
  }
}
