import 'package:elsirat/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle getHeadlineTextStyle(
    {double fontSize = 24, fontWeight = FontWeight.bold, Color? color}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color ?? AppColors.color1,
  );
}

TextStyle getTitleStyle(
    {double fontSize = 18,
    fontWeight = FontWeight.bold,
    Color? color,
    double? hight}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color ?? AppColors.color1,
    height: hight ?? 0,
  );
}

TextStyle getbodyStyle(
    {double fontSize = 16, fontWeight = FontWeight.normal, Color? color}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color ?? AppColors.color2,
  );
}

TextStyle getSmallStyle(
    {double fontSize = 14, fontWeight = FontWeight.normal, Color? color}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color ?? AppColors.color1,
  );
}
