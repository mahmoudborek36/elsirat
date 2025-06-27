import 'package:elsirat/core/services/notification/notification_services.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/fearture/azkar/presention/pages/azkar_screen.dart';
import 'package:elsirat/fearture/prayTime/presention/pages/pray_screen.dart';
import 'package:elsirat/screens/counter_screen.dart';
import 'package:elsirat/screens/suraList/pages/surah_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:timezone/timezone.dart' as tz;

class NavigationbarScreen extends StatefulWidget {
  const NavigationbarScreen({super.key});

  @override
  State<NavigationbarScreen> createState() => _NavigationbarScreenState();
}

class _NavigationbarScreenState extends State<NavigationbarScreen> {
  List<Widget> screens = [
    SurahListScreen(),
    HomeScreen(),
    CounterScreen(),
    AzkarScreen()
  ];
  int isSleacted = 0;
  int currentIndex = 0;
  int isTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.back,
      body: Stack(
        children: [
          screens[currentIndex],
          PositionedDirectional(
            bottom: 25,
            start: 0,
            end: 0,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSleacted = 0;
                        isTap = 0;
                        currentIndex = isTap;
                      });
                    },
                    child: Container(
                      height: 60.h,
                      width: 59.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSleacted == 0
                              ? AppColors.color1
                              : AppColors.contanierCoror),
                      child: Image.asset(
                        "assets/images/bookclose.png",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSleacted = 1;
                        isTap = 1;
                        currentIndex = isTap;
                      });
                    },
                    child: Container(
                      height: 60.h,
                      width: 59.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSleacted == 1
                              ? AppColors.color1
                              : AppColors.contanierCoror),
                      child: Image.asset(
                        "assets/images/mousq.png",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSleacted = 2;
                        isTap = 2;
                        currentIndex = isTap = isSleacted;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 60.h,
                      width: 59.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSleacted == 2
                              ? AppColors.color1
                              : AppColors.contanierCoror),
                      child: Image.asset(
                        "assets/images/counter.png",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSleacted = 3;
                        isTap = 3;
                        currentIndex = isTap = isSleacted;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        height: 60.h,
                        width: 59.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSleacted == 3
                                ? AppColors.color1
                                : AppColors.contanierCoror),
                        child: Icon(
                          Icons.bedtime,
                          size: 40,
                          color: AppColors.white,
                        )),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
