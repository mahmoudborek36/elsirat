class Text {
  int? id;
  String? arabicText;
  String? languageArabicTranslatedText;
  String? translatedText;
  int? repeat;
  String? audio;

  Text({
    this.id,
    this.arabicText,
    this.languageArabicTranslatedText,
    this.translatedText,
    this.repeat,
    this.audio,
  });

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        id: json['ID'] as int?,
        arabicText: json['ARABIC_TEXT'] as String?,
        languageArabicTranslatedText:
            json['LANGUAGE_ARABIC_TRANSLATED_TEXT'] as String?,
        translatedText: json['TRANSLATED_TEXT'] as String?,
        repeat: json['REPEAT'] as int?,
        audio: json['AUDIO'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'ARABIC_TEXT': arabicText,
        'LANGUAGE_ARABIC_TRANSLATED_TEXT': languageArabicTranslatedText,
        'TRANSLATED_TEXT': translatedText,
        'REPEAT': repeat,
        'AUDIO': audio,
      };
}
