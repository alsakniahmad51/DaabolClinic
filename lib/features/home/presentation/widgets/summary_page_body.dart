import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/home/presentation/widgets/left_row_item_with_border.dart';
import 'package:clinic/features/home/presentation/widgets/right_row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryPageBody extends StatelessWidget {
  const SummaryPageBody({
    super.key,
    required this.orderCounts,
    required this.formattedPrice,
    required this.date,
    required this.title,
  });

  final Map<String, int> orderCounts;
  final String formattedPrice;
  final String date;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title $date',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor)),
                children: [
                  RightRowItem(
                    topRadius: 8.r,
                    child: const Text(
                      'نوع الطلب',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const LeftRowItemWithBorder(
                    child: Text(
                      'عدد الطلبات',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              ...orderCounts.entries.map((entry) {
                return TableRow(
                  children: [
                    Container(
                      height: 40.h,
                      decoration: const BoxDecoration(
                        color: AppColor.secondColor,
                      ),
                      child: Center(
                        child: Text(
                          entry.key,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    LeftRowItemWithBorder(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primaryColor)),
                      child: Center(
                        child: Text(
                          entry.value.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                  ],
                );
              }),
              TableRow(
                children: [
                  RightRowItem(
                      bottomRadius: 8.r,
                      child: const Text(
                        'إجمالي الفواتير',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                  LeftRowItemWithBorder(
                      child: Container(
                    height: 200.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryColor)),
                    child: Center(
                      child: Text(
                        '$formattedPrice ل.س',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
