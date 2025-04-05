// ignore_for_file: use_build_context_synchronously

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/file_uploader.dart';
import 'package:clinic/core/util/widgets/custom_text_field.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/manager/fetch_order_cubit/order_cubit.dart';
import 'package:clinic/features/home/presentation/manager/update_price_order_cubit/update_order_cubit.dart';
import 'package:clinic/features/home/presentation/manager/update_state_order_cubit/update_state_order_cubit.dart';
import 'package:clinic/features/home/presentation/pages/page_view.dart';
import 'package:clinic/features/home/presentation/widgets/detailes_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:supabase_flutter/supabase_flutter.dart';

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
  late Supabase supabase;
  @override
  void initState() {
    super.initState();
    supabase = Supabase.instance;
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
                            'تأكيد عملية التصوير بدون ارسال صورة',
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
                  if (widget.order.imageExtention == 0)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => fileUploader.pickAndUploadFile(),
                          icon: const Icon(Icons.upload_file,
                              color: Colors.white),
                          label: const Text(
                            'ارسال صورة',
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

  void _confirmImaging(BuildContext context) async {
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
              onPressed: () async {
                await supabase.client
                    .from('orders')
                    .update({'image_extention': 0});

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
