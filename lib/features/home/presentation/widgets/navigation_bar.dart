import 'package:clinic/features/home/presentation/widgets/page_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.pageViewBody});
  final PageViewBody pageViewBody;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150), // المدة
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            // scale transition
            child: SvgPicture.asset(
              widget.pageViewBody.imagePath,
              key: ValueKey<String>(
                  widget.pageViewBody.imagePath), // مفتاح لتحديد التغيير
              fit: BoxFit.fill,
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 120.w, bottom: 15.h),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.pageViewBody.pageController.jumpToPage(0);
                    widget.pageViewBody.animateNavBar(0);
                  });
                },
                child: SizedBox(
                  height: 52.h,
                  width: widget.pageViewBody.widthBotton1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 21.h),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.pageViewBody.pageController.jumpToPage(1);
                    widget.pageViewBody.animateNavBar(1);
                  });
                },
                child: SizedBox(
                  height: 45.h,
                  width: widget.pageViewBody.widthBotton2,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 35.w, bottom: 23.h),
            //   child: InkWell(
            //     onTap: () {
            //       setState(() {
            //         widget.pageViewBody.pageController.jumpToPage(2);
            //         widget.pageViewBody.animateNavBar(2);
            //       });
            //     },
            //     child: SizedBox(
            //       height: 40.h,
            //       width: 40.w,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 36.w, bottom: 26.h),
            //   child: InkWell(
            //     onTap: () {
            //       setState(() {
            //         widget.pageViewBody.pageController.jumpToPage(3);
            //         widget.pageViewBody.animateNavBar(3);
            //       });
            //     },
            //     child: SizedBox(
            //       height: 40.h,
            //       width: 40.w,
            //     ),
            //   ),
            // )
          ],
        )
      ],
    );
  }
}
