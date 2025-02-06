import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/widgets/custom_button.dart';
import 'package:clinic/features/doctors/presentation/manager/docotr_order_cubit/doctor_order_cubit.dart';
import 'package:clinic/features/doctors/presentation/widgets/order_doctor_item.dart';
import 'package:clinic/features/home/presentation/pages/summary_page.dart';
import 'package:clinic/features/home/presentation/widgets/offlin_page.dart';
import 'package:clinic/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorOrdersHistory extends StatelessWidget {
  const DoctorOrdersHistory({
    super.key,
    required this.doctorId,
    required this.doctorName,
    this.selectedMonth,
    this.selectedYear,
  });

  final int doctorId;
  final String doctorName;
  final int? selectedMonth;
  final int? selectedYear;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    final now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

    if (selectedMonth != null && selectedYear != null) {
      startOfMonth = DateTime(selectedYear!, selectedMonth!, 1);
      endOfMonth = DateTime(selectedYear!, selectedMonth! + 1, 0);
    }
    if (context.read<DoctorOrdersCubit>().state is DoctorOrdersInitial ||
        context.read<DoctorOrdersCubit>().state is DoctorOrdersLoaded) {
      context
          .read<DoctorOrdersCubit>()
          .fetchOrders(doctorId, startOfMonth, endOfMonth);
    }
    return BlocBuilder<DoctorOrdersCubit, DoctorOrdersState>(
      builder: (context, state) {
        if (state is DoctorOrdersLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.primaryColor),
          );
        } else if (state is DoctorOrdersLoaded) {
          final orders = state.orders;
          orders.sort((a, b) => b.date.compareTo(a.date));
          String formattedDate = '';
          if (orders.isNotEmpty) {
            String dateTime = orders[0].date.toString();
            var parts = dateTime.split(' ');
            String date = parts[0];

            var dateParts = date.split('-');
            formattedDate = '${dateParts[1]}-${dateParts[0]}';
          }

          return RefreshIndicator(
            color: AppColor.primaryColor,
            onRefresh: () {
              final nowTime = DateTime.now();
              DateTime start = DateTime(nowTime.year, nowTime.month, 1);
              DateTime end = DateTime(nowTime.year, nowTime.month + 1, 0);
              return context.read<DoctorOrdersCubit>().fetchOrders(
                    doctorId,
                    start,
                    end,
                  );
            },
            child: Column(
              children: [
                SizedBox(height: 10.h),
                SearchTextFiled(
                  suffix: GestureDetector(
                    child: const Icon(
                      Icons.bar_chart,
                      size: 28,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SummaryPage(
                            ordersToday: orders,
                            title: 'ملخص الجرد الشهري',
                            doctorName: 'الطبيب: $doctorName',
                            addressTable: 'جدول الجرد لشهر ',
                            date: '$formattedDate :',
                          ),
                        ),
                      );
                    },
                  ),
                  prefix: const Icon(Icons.search),
                  textEditingController: searchController,
                  hint: 'ابحث عن اسم المريض',
                  onChanged: (query) {
                    context.read<DoctorOrdersCubit>().searchOrders(query);
                  },
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderDoctorItem(
                        order: orders[index],
                        doctorName: doctorName,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is DoctorOrdersError) {
          return state.message == errorDoctorOrdersHistoryOffline ||
                  state.message.contains("SocketException")
              ? OfflinPage(onTap: () {
                  final nowTime = DateTime.now();
                  DateTime start = DateTime(nowTime.year, nowTime.month, 1);
                  DateTime end = DateTime(nowTime.year, nowTime.month + 1, 0);
                  context.read<DoctorOrdersCubit>().fetchOrders(
                        doctorId,
                        start,
                        end,
                      );
                })
              : Center(
                  child: Column(
                    children: [
                      Text(
                        'حدث خطأ: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      CustomButton(
                          title: "إعادة التحميل",
                          color: AppColor.primaryColor,
                          onTap: () {
                            final nowTime = DateTime.now();
                            DateTime start =
                                DateTime(nowTime.year, nowTime.month, 1);
                            DateTime end =
                                DateTime(nowTime.year, nowTime.month + 1, 0);
                            context.read<DoctorOrdersCubit>().fetchOrders(
                                  doctorId,
                                  start,
                                  end,
                                );
                          },
                          titleColor: Colors.white)
                    ],
                  ),
                );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
