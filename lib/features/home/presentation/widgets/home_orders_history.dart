import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/widgets/orders_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeOrdersHistory extends StatelessWidget {
  const HomeOrdersHistory({super.key, required this.order});
  final List<Order> order;
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    // تصفية الطلبات الخاصة باليوم الحالي فقط
    final ordersExceptToday = order.where((order) {
      return !(order.date.year == today.year &&
          order.date.month == today.month &&
          order.date.day == today.day);
    }).toList();

    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: SizedBox(
        height: ordersExceptToday.isEmpty
            ? 50.h
            : (ordersExceptToday.length == 1 ? 100.h : 200.h),
        child: ordersExceptToday.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.h),
                  child: Text(
                    "لا توجد طلبات",
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                ),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ordersExceptToday.length == 1 ? 1 : 2,
                itemBuilder: (context, index) {
                  final data = ordersExceptToday[index];

                  String dateTime = data.date.toString();
                  var parts = dateTime.split(' ');
                  String date = parts[0];

                  return OrdersItem(
                    data: data,
                    time: date,
                  );
                },
              ),
      ),
    );
  }
}



/**
 * 
 * 
 * 
 * 
 */