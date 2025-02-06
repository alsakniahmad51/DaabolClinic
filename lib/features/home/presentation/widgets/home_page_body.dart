import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/functions/navigator.dart';
import 'package:clinic/features/examinatios_prices/presentation/pages/examination_page.dart';
import 'package:clinic/features/home/presentation/manager/fetch_order_cubit/order_cubit.dart';
import 'package:clinic/features/home/presentation/pages/orders_history.dart';
import 'package:clinic/features/home/presentation/pages/orders_today.dart';
import 'package:clinic/features/home/presentation/widgets/custom_shimmer.dart';
import 'package:clinic/features/home/presentation/widgets/home_app_bar.dart';
import 'package:clinic/features/home/presentation/widgets/home_orders_history.dart';
import 'package:clinic/features/home/presentation/widgets/home_orders_today.dart';
import 'package:clinic/features/home/presentation/widgets/home_search_text_field.dart';
import 'package:clinic/features/home/presentation/widgets/lable_orders.dart';
import 'package:clinic/features/home/presentation/widgets/offlin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                SizedBox(height: 100.h),
                const Expanded(child: CustomShimmer()),
              ],
            ),
          );
        } else if (state is OrderLoaded) {
          final orders = state.orders;
          orders.sort((a, b) => b.date.compareTo(a.date));
          return RefreshIndicator(
            backgroundColor: Colors.white,
            color: AppColor.primaryColor,
            onRefresh: () async {
              final now = DateTime.now();
              final startOfMonth = DateTime(now.year, now.month, 1);
              final endOfMonth = DateTime(now.year, now.month + 1, 0);
              context.read<OrderCubit>().fetchOrders(startOfMonth, endOfMonth);
            },
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    HomeAppBar(
                      onDateSelected: (selectedDate) {
                        final startOfMonth =
                            DateTime(selectedDate.year, selectedDate.month, 1);
                        final endOfMonth = DateTime(
                            selectedDate.year, selectedDate.month + 1, 0);
                        context
                            .read<OrderCubit>()
                            .fetchOrders(startOfMonth, endOfMonth);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Moving.navToPage(
                                context: context,
                                page: const ExaminationPage());
                          },
                          child: const Icon(
                            size: 30,
                            Icons.monetization_on_outlined,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                            width: 330.w,
                            child: HomeSearchTextField(orders: orders)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: LableOrders(
                        onTap: () {
                          Moving.navToPage(
                            context: context,
                            page: OrdersTodayPage(
                              allOrders: orders,
                            ),
                          );
                        },
                        text: 'طلبات اليوم',
                        padding: 200.w,
                      ),
                    ),
                    HomeOrdersToday(
                      order: orders,
                    ),
                    LableOrders(
                      text: 'سجل الطلبات السابقة',
                      padding: 120,
                      onTap: () {
                        Moving.navToPage(
                          context: context,
                          page: OrdersHistoryPage(
                            allOrders: orders,
                          ),
                        );
                      },
                    ),
                    HomeOrdersHistory(
                      order: orders,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is OrderError) {
          return state.message == errorOrderOffline ||
                  state.message == "لا يوجد اتصال بالإنترنت" ||
                  state.message.contains("SocketException")
              ? OfflinPage(
                  onTap: () {
                    final now = DateTime.now();
                    final startOfMonth = DateTime(now.year, now.month, 1);
                    final endOfMonth = DateTime(now.year, now.month + 1, 0);
                    context
                        .read<OrderCubit>()
                        .fetchOrders(startOfMonth, endOfMonth);
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('حدث خطأ: ${state.message}'),
                    ],
                  ),
                );
        } else {
          return const Center(child: Text('لم يتم العثور على طلبات.'));
        }
      },
    );
  }
}
