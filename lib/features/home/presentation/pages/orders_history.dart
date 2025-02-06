// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/home/presentation/pages/all_order.dart';
import 'package:clinic/features/home/presentation/pages/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/widgets/search_text_field.dart';
import 'package:clinic/features/home/presentation/widgets/orders_item.dart';
import 'package:flutter_svg/svg.dart';
import 'filter_page.dart';

class OrdersHistoryPage extends StatefulWidget {
  final List<Order> allOrders;

  const OrdersHistoryPage({super.key, required this.allOrders});

  @override
  _OrdersHistoryPageState createState() => _OrdersHistoryPageState();
}

class _OrdersHistoryPageState extends State<OrdersHistoryPage> {
  List<Order> filteredOrders = [];
  String? selectedImageType;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(); // FocusNode للتحكم في الفوكس

  @override
  void initState() {
    super.initState();
    filteredOrders = widget.allOrders; // جميع الطلبات بشكل افتراضي

    // تفعيل الفوكس على TextField عند دخول الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(searchFocusNode);
    });
  }

  void _applyFilters(List<String>? doctorNames, String? imageType) {
    setState(() {
      filteredOrders = widget.allOrders.where((order) {
        bool matchesDoctor = doctorNames == null ||
            doctorNames.isEmpty ||
            doctorNames.contains(order.doctorName);

        bool matchesType = imageType == null ||
            order.detail!.type.typeName.toLowerCase() ==
                imageType.toLowerCase();

        return matchesDoctor && matchesType;
      }).toList();
    });
  }

  void _filterOrders(String query) {
    setState(() {
      filteredOrders = widget.allOrders
          .where((order) =>
              order.patientName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    // لا تنسى تنظيف الـ FocusNode عند التخلص من الويجت
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    if (filteredOrders.isNotEmpty) {
      String dateTime = filteredOrders[0].date.toString();
      var parts = dateTime.split(' ');
      String date = parts[0];

      var dateParts = date.split('-');
      formattedDate = '${dateParts[1]}-${dateParts[0]}';
    }

    filteredOrders.sort((a, b) => b.date.compareTo(a.date));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: GestureDetector(
                child: const Icon(
                  Icons.bar_chart,
                  size: 28,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryPage(
                        ordersToday: filteredOrders,
                        title: 'الجرد الشهري',
                        doctorName: '',
                        addressTable: ' لشهر',
                        date: "$formattedDate :",
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: GestureDetector(
                child: const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Icon(
                    Icons.list,
                    size: 28,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Allorderview(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const Text('سجل الطلبات'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SearchTextFiled(
                prefix: const Icon(Icons.search),
                suffix: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterPage(),
                      ),
                    );
                    if (result != null) {
                      _applyFilters(result['selectedDoctors'],
                          result['selectedImageType']);
                    }
                  },
                  child: SvgPicture.asset(
                    color: Colors.grey[400],
                    filter,
                    fit: BoxFit.none,
                  ),
                ),
                textEditingController: searchController,
                focusNode: searchFocusNode, // ربط FocusNode بـ TextField
                hint: 'ابحث عن اسم المريض',
                onChanged: _filterOrders,
              ),
            ),
            Expanded(
              child: filteredOrders.isEmpty
                  ? const Center(child: Text('لا توجد طلبات حالياً'))
                  : ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        String dateTime = filteredOrders[index].date.toString();
                        var parts = dateTime.split(' ');
                        String date = parts[0];
                        return OrdersItem(
                          data: filteredOrders[index],
                          time: date,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
