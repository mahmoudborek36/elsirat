import 'package:elsirat/core/utils/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      fontFamily: 'Amiri',
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Amiri',
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.color1,
        unselectedItemColor: AppColors.black,
      ),
      // colorScheme: ColorScheme.fromSeed(
      //     seedColor: AppColors.accentColor, onSurface: AppColors.black),
      inputDecorationTheme: const InputDecorationTheme(
          // fillColor: AppColors.background,
          // filled: true,
          // suffixIconColor: AppColors.accentColor,
          // prefixIconColor: AppColors.accentColor,
          // hintStyle: TextStyle(
          //   fontSize: 15,
          //   color: AppColors.greyColor,
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          )));
}
