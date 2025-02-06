// ignore_for_file: deprecated_member_use

import 'package:clinic/features/home/presentation/widgets/offlin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/examinatios_prices/presentation/manager/examination_cubit/examination_cubit.dart';
import 'package:clinic/features/examinatios_prices/presentation/widgets/examination_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExaminationPageBody extends StatelessWidget {
  const ExaminationPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final examinationCubit = context.read<ExaminationCubit>();

    if (examinationCubit.state is ExaminationInitial) {
      examinationCubit.fetchExaminationDetails();
    }

    return BlocBuilder<ExaminationCubit, ExaminationState>(
      builder: (context, examinationState) {
        if (examinationState is ExaminationLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.primaryColor),
          );
        }

        if (examinationState is ExaminationError) {
          if (examinationState.message.contains("SocketException")) {
            return OfflinPage(onTap: () {
              BlocProvider.of<ExaminationCubit>(context)
                  .fetchExaminationDetails();
            });
          }
          return Center(
            child: Text('Error in Examination: ${examinationState.message}'),
          );
        }

        if (examinationState is ExaminationLoaded) {
          final prices = examinationState.prices;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10.w),
                    child: Text(
                      "الخدمات التصويرية :",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    prices.sort((a, b) => a.priceId.compareTo(b.priceId));
                    prices.reversed;
                    return ExaminationItem(
                      prices: prices[index],
                    );
                  },
                  childCount: prices.length,
                ),
              ),
            ],
          );
        }

        return const Center(
          child: Text('No data available.'),
        );
      },
    );
  }
}
