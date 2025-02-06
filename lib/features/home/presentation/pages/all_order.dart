// ignore_for_file: file_names

import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/manager/fetch_order_cubit/order_cubit.dart';
import 'package:clinic/features/home/presentation/widgets/custom_shimmer.dart';
import 'package:clinic/features/home/presentation/widgets/orders_item.dart';
import 'package:clinic/features/home/presentation/widgets/search_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Allorderview extends StatefulWidget {
  const Allorderview({
    super.key,
  });

  @override
  State<Allorderview> createState() => _AllorderviewState();
}

class _AllorderviewState extends State<Allorderview> {
  TextEditingController searchController = TextEditingController();
  late OrderCubit orderCubit;
  List<Order> filteredOrders = []; // قائمة مفلترة

  @override
  void initState() {
    super.initState();
    orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.fetchOrders(
      DateTime(2000),
      DateTime.now(),
    );
  }

  @override
  void dispose() {
    searchController.dispose();

    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    orderCubit.fetchOrders(startOfMonth, endOfMonth);

    super.dispose();
  }

  void _filterOrders(String query, List<Order> list) {
    setState(() {
      filteredOrders = list
          .where((order) =>
              order.patientName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text('عرض كل الطلبات'),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoaded) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16.h),
                    child: SearchTextFiled(
                      prefix: const Icon(Icons.search),
                      hint: 'اسم المريض',
                      textEditingController: searchController,
                      onChanged: (value) => _filterOrders(value, state.orders),
                    ),
                  ),
                  Expanded(
                    child: filteredOrders.isNotEmpty
                        ? ListView.builder(
                            itemCount: filteredOrders.length,
                            itemBuilder: (context, index) {
                              String dateTime =
                                  filteredOrders[index].date.toString();
                              var parts = dateTime.split(' ');
                              String date = parts[0];
                              return OrdersItem(
                                data: filteredOrders[index],
                                time: date,
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: state.orders.length,
                            itemBuilder: (context, index) {
                              String dateTime =
                                  state.orders[index].date.toString();
                              var parts = dateTime.split(' ');
                              String date = parts[0];
                              return OrdersItem(
                                data: state.orders[index],
                                time: date,
                              );
                            },
                          ),
                  ),
                ],
              );
            } else if (state is OrderLoading) {
              return const Directionality(
                  textDirection: TextDirection.rtl, child: CustomShimmer());
            } else {
              return const Center(child: Text('حدث خطأ أثناء تحميل الطلبات.'));
            }
          },
        ),
      ),
    );
  }
}
