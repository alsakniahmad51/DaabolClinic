import 'package:clinic/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.validator,
    required this.title,
    required this.radius,
    required this.textEditingController,
    required this.keyboardType,
    this.prefix,
    this.suffix,
    this.enableColor,
    this.focuseColor,
    this.onSearch,
    this.enabled,
    this.focusNode,
  });
  final String title;
  final double radius;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final Color? enableColor;
  final Color? focuseColor;
  final ValueChanged<String>? onSearch;
  final bool? enabled;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(radius.r)),
      width: 361.w,
      child: TextFormField(
        focusNode: focusNode,
        enabled: enabled ?? true,
        cursorColor: AppColor.primaryColor,
        onChanged: onSearch,
        validator: validator,
        keyboardType: keyboardType,
        controller: textEditingController,
        style: const TextStyle(fontSize: 12, height: 1),
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: title,
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),
            border: outLineInputBorder(
                width: 1,
                radius: radius,
                color: enableColor ?? Colors.transparent),
            disabledBorder: outLineInputBorder(
                width: 1,
                radius: radius,
                color: enableColor ?? Colors.transparent),
            enabledBorder: outLineInputBorder(
                width: 1,
                radius: radius,
                color: enableColor ?? Colors.transparent),
            focusedBorder: outLineInputBorder(
                width: 2,
                radius: radius,
                color: focuseColor ?? Colors.transparent)),
      ),
    );
  }

  OutlineInputBorder outLineInputBorder(
      {required double width, required double radius, required Color color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: color, width: width));
  }
}
