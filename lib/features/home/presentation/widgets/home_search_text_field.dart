// ignore_for_file: deprecated_member_use

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/functions/navigator.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/pages/orders_history.dart';
import 'package:clinic/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeSearchTextField extends StatelessWidget {
  const HomeSearchTextField({
    super.key,
    required this.orders,
  });

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Moving.navToPage(
          context: context,
          page: OrdersHistoryPage(
            allOrders: orders,
          ),
        );
      },
      child: SearchTextFiled(
        suffix: const Icon(Icons.search),
        prefix: InkWell(
          child: SvgPicture.asset(
            filter,
            color: Colors.white,
            fit: BoxFit.none,
          ),
        ),
        enabled: false,
        hint: "مريض, تصوير مقطعي",
      ),
    );
  }
}
