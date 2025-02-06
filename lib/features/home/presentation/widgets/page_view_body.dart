// ignore_for_file: must_be_immutable

import 'package:clinic/core/util/constants.dart';
import 'package:clinic/features/doctors/presentation/pages/doctors_page.dart';
import 'package:clinic/features/home/presentation/pages/home_page.dart';
import 'package:clinic/features/home/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewBody extends StatefulWidget {
  PageViewBody({
    super.key,
  });

  int currentIndex = 0;
  double widthBotton1 = 50.w;
  double widthBotton2 = 90.w;
  String imagePath = home;
  var pageController = PageController(
    initialPage: 1,
  );
  void animateNavBar(int value) {
    if (value == 0) {
      widthBotton1 = 90.w;
      widthBotton2 = 50.w;
      imagePath = doctor;
    } else if (value == 1) {
      widthBotton1 = 50.w;
      widthBotton2 = 90.w;
      // padding = EdgeInsets.zero;
      imagePath = home;
    }
  }

  @override
  State<PageViewBody> createState() => _PageViewBodyState();
}

class _PageViewBodyState extends State<PageViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        pageViewBody: widget,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            widget.animateNavBar(value);
          });
        },
        controller: widget.pageController,
        children: const [
          DoctorsPage(),
          HomePage(),
        ],
      ),
    );
  }
}
