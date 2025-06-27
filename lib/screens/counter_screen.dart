import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

int counter = 0;

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        backgroundColor: AppColors.back,
        title: Text(
          "Counter",
          style: getHeadlineTextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "The Way To Heaven",
              style: getTitleStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.color1,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        counter.toString(),
                        style: getTitleStyle(
                            color: AppColors.back,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            counter++;
                          });
                        },
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: AppColors.back,
                          child: Icon(Icons.add, color: AppColors.color1),
                        ),
                      ),
                      const SizedBox(height: 20), // مسافة بين الزرين
                      TextButton(
                        onPressed: () {
                          setState(() {
                            counter = 0;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.back,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'Reset',
                          style: getbodyStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
