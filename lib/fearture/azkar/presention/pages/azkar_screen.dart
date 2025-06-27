import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/fearture/azkar/data/model/get_all_of_azkar_data/english.dart';
import 'package:elsirat/fearture/azkar/data/model/get_all_of_azkar_data/get_all_of_azkar_data.dart';
import 'package:elsirat/fearture/azkar/presention/AzkarPageViewScreen%20.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  Future<List<English>> loadAllAzkarData() async {
    final jsonString =
        await rootBundle.loadString('assets/data/husn_en.json'); // update path
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final data = GetAllOfAzkarData.fromJson(jsonMap);
    return data.english ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        title: const Text(
          'Azkar',
          style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: AppColors.color1),
        ),
        backgroundColor: AppColors.back,
      ),
      body: FutureBuilder<List<English>>(
        future: loadAllAzkarData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('فشل في تحميل الأذكار'));
          }

          final azkarCategories = snapshot.data!;

          return ListView.builder(
            itemCount: azkarCategories.length,
            itemBuilder: (context, index) {
              final category = azkarCategories[index];
              return ListTile(
                title: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.color1,
                        borderRadius: BorderRadius.circular(22)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            category.title ?? '',
                            style: getbodyStyle(color: AppColors.white),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.back,
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AzkarDetailsPage(english: category),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
