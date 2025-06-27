import 'package:elsirat/core/functions/navigation.dart';
import 'package:elsirat/core/services/local.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/fearture/auth/presentaion/pages/Login_screen.dart';
import 'package:elsirat/screens/suraList/pages/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class drawerMenuWidgets extends StatelessWidget {
  const drawerMenuWidgets({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 180,
        height: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: Drawer(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.white),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.color1,
                                shape: BoxShape.circle),
                            child: Image.asset("assets/images/Group 5.png"),
                          ),
                          Gap(5),
                          Expanded(
                            child: Text(
                              user!.displayName ?? "",
                              style: getHeadlineTextStyle(),
                            ),
                          )
                        ],
                      ),
                      Gap(20),
                      Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: AppColors.color1,
                          ),
                          Gap(5),
                          Expanded(
                            child: Text(
                              "notifications",
                              style: getTitleStyle(),
                            ),
                          )
                        ],
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () {
                          push(context, SettingScreen());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: AppColors.color1,
                            ),
                            Gap(5),
                            Expanded(
                              child: Text(
                                "Settings",
                                style: getTitleStyle(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          AppLocalStorege.removedata(AppLocalStorege.isreg);
                          AppLocalStorege.removedata(AppLocalStorege.islog);
                          pushAndRemoveUntil(context, LogInScreen());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: AppColors.color1,
                            ),
                            Gap(5),
                            Expanded(
                              child: Text(
                                "Logout",
                                style: getTitleStyle(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
