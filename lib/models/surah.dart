import 'dart:convert';

import 'package:flutter/services.dart';

class Verse {
  final int id;
  final String text;

  Verse({required this.id, required this.text});

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'],
      text: json['text'],
    );
  }
}

class Surah {
  final int id;
  final String name;
  final String transliteration;
  final String type;
  final int totalVerses;
  final List<Verse> verses;

  Surah({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.type,
    required this.totalVerses,
    required this.verses,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    var versesJson = json['verses'] as List;
    List<Verse> versesList = versesJson.map((v) => Verse.fromJson(v)).toList();

    return Surah(
      id: json['id'],
      name: json['name'],
      transliteration: json['transliteration'],
      type: json['type'],
      totalVerses: json['total_verses'],
      verses: versesList,
    );
  }
}

List<Surah> parseSurahs(String jsonString) {
  final parsed = json.decode(jsonString) as List;
  return parsed.map((json) => Surah.fromJson(json)).toList();
}

Future<List<Surah>> loadQuran() async {
  final jsonString = await rootBundle.loadString('assets/data/quran.json');
  return parseSurahs(jsonString);
}
