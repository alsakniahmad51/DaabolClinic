// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/supabase_keys.dart';
import 'package:clinic/core/util/widgets/custom_text_field.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/manager/fetch_order_cubit/order_cubit.dart';
import 'package:clinic/features/home/presentation/manager/update_price_order_cubit/update_order_cubit.dart';
import 'package:clinic/features/home/presentation/manager/update_state_order_cubit/update_state_order_cubit.dart';
import 'package:clinic/features/home/presentation/pages/page_view.dart';
import 'package:clinic/features/home/presentation/widgets/detailes_table.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mime/mime.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_progress_uploads/supabase_progress_uploads.dart';

class OrderDetailes extends StatefulWidget {
  const OrderDetailes({
    super.key,
    required this.order,
  });
  final Order order;

  @override
  State<OrderDetailes> createState() => _OrderDetailesState();
}

class _OrderDetailesState extends State<OrderDetailes> {
  late SupabaseUploadService _uploadService;
  late SupabaseUploadController _uploadController;
  double _singleProgress = 0.0;
  double _multipleProgress = 0.0;
  late Supabase supabase;
  @override
  void initState() {
    super.initState();
    supabase = Supabase.instance;

    _uploadService = SupabaseUploadService(supabase.client, 'images');
    _uploadController = SupabaseUploadController(supabase.client, 'images');
  }

  @override
  Widget build(BuildContext context) {
    final FileUploader fileUploader = FileUploader(
        context: context,
        orderId: widget.order.id.toString(),
        supabase: supabase);
    String dateTime = widget.order.date.toString();
    var parts = dateTime.split(' ');
    String date = parts[0];
    DateTime time = widget.order.date;
    String formattedTime = intl.DateFormat('hh:mm a').format(time);

    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateStateOrderCubit, UpdateStateOrderState>(
          listener: (context, state) {
            if (state is UpdateStateOrderLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is UpdateStateOrderSucsecc) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم تأكيد عملية التصوير بنجاح!',
                    textDirection: TextDirection.rtl,
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              final now = DateTime.now();
              final startOfMonth = DateTime(now.year, now.month, 1);
              final endOfMonth = DateTime(now.year, now.month + 1, 0);
              context.read<OrderCubit>().fetchOrders(startOfMonth, endOfMonth);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Pageview()),
                (Route<dynamic> route) => false,
              );
            } else if (state is UpdateStateOrderFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'فشلت عملية تأكيد التصوير!',
                    textDirection: TextDirection.rtl,
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.of(context).pop();
            }
          },
        ),
        BlocListener<UpdatePriceOrderCubit, UpdateOrderState>(
          listener: (context, state) {
            if (state is UpdateOrderLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is UpdateOrderSuccess) {
              Navigator.of(context).pop();
              final now = DateTime.now();
              final startOfMonth = DateTime(now.year, now.month, 1);
              final endOfMonth = DateTime(now.year, now.month + 1, 0);
              context.read<OrderCubit>().fetchOrders(startOfMonth, endOfMonth);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم تحديث السعر بنجاح!',
                    textDirection: TextDirection.rtl,
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Pageview()),
                (Route<dynamic> route) => false,
              );
            } else if (state is UpdateOrderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'فشل تحديث السعر!',
                    textDirection: TextDirection.rtl,
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: Text(
              'معلومات الطلب',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DetailesTable(
                      order: widget.order,
                      date: date,
                      formattedTime: formattedTime,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  if (!widget.order.isImaged)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _confirmImaging(context),
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white),
                          label: const Text(
                            'تأكيد عملية التصوير',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20.h),
                  if (!widget.order.isImaged)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => fileUploader.pickAndUploadFile(),
                          icon: const Icon(Icons.upload_file,
                              color: Colors.white),
                          label: const Text(
                            'رفع ملف',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20.h),
                  if (!widget.order.isImaged)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _showEditPriceSheet(context),
                          icon: const Icon(Icons.discount, color: Colors.white),
                          label: const Text(
                            'إضافة حسم',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 30.h),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: widget.order.isImaged
                          ? Colors.green.shade100
                          : Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          widget.order.isImaged
                              ? Icons.check_circle
                              : Icons.access_time_filled,
                          color: widget.order.isImaged
                              ? Colors.green
                              : Colors.amber,
                          size: 24.w,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            widget.order.isImaged
                                ? 'تم إتمام عملية تصوير الأشعة بنجاح.'
                                : 'بانتظار وصول المريض لاستكمال إجراءات الطلب.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: widget.order.isImaged
                                  ? Colors.green.shade800
                                  : Colors.amber.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmImaging(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تأكيد عملية التصوير'),
          content: const Text(
              'هل أنت متأكد من تأكيد عملية التصوير؟ هذا الإجراء نهائي.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<UpdateStateOrderCubit>(context)
                    .updateOrderState(widget.order.id);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
              ),
              child: const Text(
                'تأكيد',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPriceSheet(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
          top: 20.h,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'إضافة حسم للطلب',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                enableColor: AppColor.primaryColor,
                focuseColor: AppColor.primaryColor,
                title: 'أدخل قيمة الحسم',
                radius: 8.0.r,
                textEditingController: priceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب ألا يكون الحقل فارغًا';
                  }
                  final int? discount = int.tryParse(value);
                  if (discount == null) {
                    return 'يجب إدخال قيمة رقمية صالحة';
                  }
                  if (discount >= widget.order.price) {
                    return 'يجب ألا يكون الحسم أكبر من أو يساوي الفاتورة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final newDiscount = int.tryParse(priceController.text);
                    if (newDiscount != null) {
                      final newPrice = widget.order.price - newDiscount;
                      BlocProvider.of<UpdatePriceOrderCubit>(context)
                          .updateOrderPrice(widget.order.id, newPrice);
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('تأكيد التعديل'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FileUploader {
  final BuildContext context;
  final String orderId;
  final Supabase supabase;

  late final SupabaseUploadService _uploadService;
  double _progress = 0.0;
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
      print('xFile path: ${xFile.path}'); // فحص مسار الملف

      await _uploadService.uploadFile(
        xFile,
        onUploadProgress: (progress) {
          _updateProgress(progress);
        },
      );

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

      print('تم رفع الملف إلى: ');
    } catch (error) {
      print('حدث خطأ أثناء الرفع: $error');
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

class SupabaseUploadService {
  final SupabaseClient supabaseClient;
  final String bucketName;

  SupabaseUploadService(this.supabaseClient, this.bucketName);

  Future<void> uploadFile(
    XFile file, {
    required Function(double) onUploadProgress,
  }) async {
    try {
      final fileBytes = await file.readAsBytes();
      final filePath = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';

      // حجم كل جزء (chunk) - يمكنك تعديله حسب الحاجة
      const chunkSize = 256 * 1024; // 1 MB
      int totalChunks = (fileBytes.length / chunkSize).ceil();
      int uploadedBytes = 0;

      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = (i + 1) * chunkSize;
        if (end > fileBytes.length) {
          end = fileBytes.length;
        }

        // رفع الجزء الحالي
        final chunk = fileBytes.sublist(start, end);
        await supabaseClient.storage
            .from(bucketName)
            .uploadBinary(filePath, chunk,
                fileOptions: FileOptions(
                  contentType: file.mimeType,
                  upsert: true, // إذا كنت تريد استبدال الملف إذا كان موجودًا
                ));

        // تحديث التقدم
        uploadedBytes += chunk.length;
        double progress = uploadedBytes / fileBytes.length;
        onUploadProgress(progress);
      }

      onUploadProgress(1.0); // إعلام بنهاية الرفع
    } catch (error) {
      print('حدث خطأ أثناء الرفع: $error');
      rethrow;
    }
  }
}
