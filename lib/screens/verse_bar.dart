import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/models/surah.dart';
import 'package:elsirat/screens/verse_screen.dart';
import 'package:flutter/material.dart';

class VerseBar extends StatefulWidget {
  const VerseBar({super.key, required this.surah});
  final Surah surah;

  @override
  State<VerseBar> createState() => _VerseBarState();
}

class _VerseBarState extends State<VerseBar> {
  bool showArrows = true;

  @override
  void initState() {
    super.initState();
    // تخفي الأسهم بعد ثانيتين
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showArrows = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SurahPageScreen(surah: widget.surah),
          if (showArrows) ArrowsWidget(), // تظهر فقط لو showArrows = true
        ],
      ),
    );
  }
}

class ArrowsWidget extends StatelessWidget {
  const ArrowsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Spacer(flex: 4),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.color1,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                  )),
            ],
          ),
          Spacer(flex: 2),
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.color1,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.arrow_downward,
                color: AppColors.white,
              )),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
