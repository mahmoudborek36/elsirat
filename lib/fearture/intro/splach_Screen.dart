import 'package:elsirat/core/functions/navigation.dart';
import 'package:elsirat/core/services/local.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/core/widgets/custom_button.dart';
import 'package:elsirat/fearture/auth/presentaion/pages/register_screnn.dart';
import 'package:elsirat/screens/navigationBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  bool? isDone;

  @override
  void initState() {
    super.initState();
    isDone = AppLocalStorege.getData(AppLocalStorege.isdone);

    if (isDone == true) {
      Future.delayed(Duration(seconds: 3), () {
        if (AppLocalStorege.getData(AppLocalStorege.islog) != null) {
          pushAndRemoveUntil(context, NavigationbarScreen());
        } else {
          pushAndRemoveUntil(context, RegisterScrenn());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "El-Sirat",
                      style: getHeadlineTextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Learn Quran every day and",
                      style: getbodyStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.color2,
                      ),
                    ),
                    Text(
                      " recite once everyday",
                      style: getbodyStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.color2,
                      ),
                    ),
                    Gap(15),
                    Container(
                      height: 450,
                      width: 400,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.color1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Image.asset(
                        "assets/images/ChatGPT Image May 25, 2025, 08_51_24 PM.png",
                        color: AppColors.white,
                        width: 300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isDone != true)
              Positioned(
                bottom: 50,
                right: 100,
                left: 100,
                child: CustomButton(
                  text: "Get Started",
                  textStyle: getbodyStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    push(context, RegisterScrenn());
                    AppLocalStorege.cachData(AppLocalStorege.isdone, true);
                    setState(() {
                      isDone = true;
                    });
                  },
                  color: AppColors.accentColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
