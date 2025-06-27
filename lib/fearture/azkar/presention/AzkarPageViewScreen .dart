
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/fearture/azkar/data/model/get_all_of_azkar_data/english.dart';
import 'package:elsirat/screens/suraList/widgets/arroe_back_widgeta.dart';
import 'package:flutter/material.dart';

class AzkarDetailsPage extends StatelessWidget {
  final English english; // Pass the English object to this screen

  const AzkarDetailsPage({super.key, required this.english});

  @override
  Widget build(BuildContext context) {
    final dhikrList = english.text ?? [];

    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          english.title ?? '',
          style: getHeadlineTextStyle(fontSize: 13),
        ),
        automaticallyImplyLeading: false,
        leading: arroeBackWidgeta(),
        backgroundColor: AppColors.back,
      ),
      body: PageView.builder(
        itemCount: dhikrList.length,
        itemBuilder: (context, index) {
          final item = dhikrList[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              //    padding: EdgeInsets.all(),
              decoration: BoxDecoration(
                  color: AppColors.color1,
                  borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.arabicText ?? '',
                        style: const TextStyle(
                          height: 2.5,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.back,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (item.languageArabicTranslatedText != null)
                        Text(
                          ' ${item.languageArabicTranslatedText}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      const SizedBox(height: 12),
                      if (item.translatedText != null)
                        Text(
                          '${item.translatedText}',
                          style: const TextStyle(color: AppColors.white),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        '🔁 التكرار: ${item.repeat ?? 1}',
                        style: getbodyStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
