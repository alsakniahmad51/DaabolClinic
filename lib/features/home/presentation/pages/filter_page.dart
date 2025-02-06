import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/doctors/presentation/manager/docotr_cubit/doctors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedDoctors = [];
  String? selectedImageType;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('فلترة'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قائمة الأطباء
              const Text(
                'اختيار الأطباء',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              BlocBuilder<DoctorsCubit, DoctorsState>(
                builder: (context, state) {
                  if (state is DoctorsLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ));
                  } else if (state is DoctorsLoaded) {
                    return DropdownButtonFormField<String>(
                      focusColor: AppColor.primaryColor,
                      decoration: InputDecoration(
                          border: border(width: 1),
                          enabledBorder: border(width: 1),
                          focusedBorder: border(width: 2)),
                      hint: const Text('اختر طبيباً'),
                      items: state.doctors.map((doctor) {
                        return DropdownMenuItem<String>(
                          value: doctor.name,
                          child: Text(doctor.name),
                        );
                      }).toList(),
                      onChanged: (doctorName) {
                        setState(() {
                          if (doctorName != null &&
                              !selectedDoctors.contains(doctorName)) {
                            selectedDoctors.add(doctorName);
                          }
                        });
                      },
                    );
                  } else {
                    return const Text('حدث خطأ بتحميل الأطباء');
                  }
                },
              ),
              SizedBox(height: 16.h),
              // قائمة نوع الصورة
              const Text(
                'اختيار نوع الصورة',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                focusColor: AppColor.primaryColor,
                decoration: InputDecoration(
                    border: border(width: 1),
                    enabledBorder: border(width: 1),
                    focusedBorder: border(width: 2)),
                hint: const Text('اختر نوع الصورة'),
                items: [
                  'سيفالوماتريك',
                  'C.B.C.T',
                  'بانوراما',
                ].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedImageType = value;
                  });
                },
              ),
              SizedBox(height: 45.h),
              // زر تطبيق الفلترة
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  minimumSize: Size(double.infinity, 48.h),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'selectedDoctors': selectedDoctors,
                    'selectedImageType': selectedImageType,
                  });
                },
                child: Text(
                  'تطبيق الفلترة',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder border({required double width}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor, width: width),
      borderRadius: BorderRadius.circular(
        12.r,
      ),
    );
  }
}
