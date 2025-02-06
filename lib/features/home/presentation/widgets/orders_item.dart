// ignore_for_file: deprecated_member_use

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/core/util/functions/navigator.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/presentation/pages/order_detailes.dart';
import 'package:clinic/features/home/presentation/widgets/title_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrdersItem extends StatelessWidget {
  const OrdersItem({
    super.key,
    required this.data,
    required this.time,
  });
  final Order data;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
        child: GestureDetector(
          onTap: () {
            Moving.navToPage(
                context: context,
                page: OrderDetailes(
                  order: data,
                ));
          },
          child: SizedBox(
            height: 85.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,

                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Card(
                color: Colors.black12,
                child: ListTile(
                  trailing: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: SvgPicture.asset(
                      fit: BoxFit.cover,
                      data.detail!.type.typeName == 'سيفالوماتريك'
                          ? sifalo_icon
                          : (data.detail!.type.typeName == 'بانوراما'
                              ? 'assets/images/pano.svg'
                              : 'assets/images/cbct.svg'),
                      height: 44.h,
                      width: 44.w,
                    ),
                  ),
                  title: TitleListTile(
                    data: data,
                    time: time,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
