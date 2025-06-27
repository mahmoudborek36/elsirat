import 'package:elsirat/core/functions/navigation.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/core/widgets/custom_button.dart';
import 'package:elsirat/screens/suraList/pages/account_screen.dart';
import 'package:elsirat/screens/suraList/widgets/arroe_back_widgeta.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        backgroundColor: AppColors.back,
        automaticallyImplyLeading: false,
        leading: arroeBackWidgeta(),
        centerTitle: false,
        title: Text(
          "Setting",
          style: getHeadlineTextStyle(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.settings,
              color: AppColors.color1,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            CustomButton(
              text: "Account",
              onPressed: () {
                push(context, AccountScreen());
              },
            ),
            Gap(15),
            CustomButton(
              text: "Privacy & Security",
              onPressed: () {},
            ),
            Gap(15),
            CustomButton(
              text: "Help & Support",
              onPressed: () {},
            ),
            Gap(15),
            CustomButton(
              text: "About",
              onPressed: () {},
            ),
            Gap(15),
          ],
        ),
      ),
    );
  }
}
