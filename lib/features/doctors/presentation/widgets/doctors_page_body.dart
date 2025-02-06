import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/doctors/presentation/manager/docotr_cubit/doctors_cubit.dart';
import 'package:clinic/features/doctors/presentation/widgets/doctor_item.dart';
import 'package:clinic/features/home/presentation/widgets/custom_shimmer.dart';
import 'package:clinic/features/home/presentation/widgets/offlin_page.dart';
import 'package:clinic/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsPageBody extends StatelessWidget {
  const DoctorsPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        if (state is DoctorsLoading) {
          return const Directionality(
              textDirection: TextDirection.rtl, child: CustomShimmer());
        } else if (state is DoctorsLoaded) {
          final doctors = state.doctors;
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
                  child: SearchTextFiled(
                    suffix: const Icon(Icons.search),
                    textEditingController: search,
                    onChanged: (query) {
                      context.read<DoctorsCubit>().searchDoctors(query);
                    },
                    hint: 'اسم الطبيب',
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      return DoctorItem(
                        doctor: doctors[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is DoctorsError) {
          return state.message == errorDoctorOffline
              ? OfflinPage(
                  onTap: () {
                    context.read<DoctorsCubit>().fetchDoctors();
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
          return const Center(child: Text('لا يوجد بيانات'));
        }
      },
    );
  }
}



///  