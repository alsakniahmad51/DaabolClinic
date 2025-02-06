import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/widgets/orders_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeOrdersToday extends StatelessWidget {
  const HomeOrdersToday({
    super.key,
    required this.order,
  });
  final List<Order> order;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    // تصفية الطلبات الخاصة باليوم الحالي فقط
    final ordersToday = order.where((order) {
      return order.date.year == today.year &&
          order.date.month == today.month &&
          order.date.day == today.day;
    }).toList();

    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: SizedBox(
        height: ordersToday.isEmpty
            ? 50.h
            : (ordersToday.length == 1 ? 100.h : 200.h),
        child: ordersToday.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.h),
                  child: Text(
                    "لا توجد طلبات لليوم",
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                ),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ordersToday.length == 1 ? 1 : 2,
                itemBuilder: (context, index) {
                  final data = ordersToday[index];

                  // ضبط الوقت ليعكس توقيت سوريا (+03:00)
                  final syrianTime = data.date.add(const Duration(hours: -3));

                  // إعداد النص لعرض الوقت الماضي
                  timeago.setLocaleMessages('ar', timeago.ArMessages());
                  String timePassed = timeago.format(syrianTime, locale: 'ar');

                  return OrdersItem(
                    data: data,
                    time: timePassed,
                  );
                },
              ),
      ),
    );
  }
}
