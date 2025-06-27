import 'text.dart';

class English {
  int? id;
  String? title;
  String? audioUrl;
  List<Text>? text;

  English({this.id, this.title, this.audioUrl, this.text});

  factory English.fromJson(Map<String, dynamic> json) => English(
        id: json['ID'] as int?,
        title: json['TITLE'] as String?,
        audioUrl: json['AUDIO_URL'] as String?,
        text: (json['TEXT'] as List<dynamic>?)
            ?.map((e) => Text.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'TITLE': title,
        'AUDIO_URL': audioUrl,
        'TEXT': text?.map((e) => e.toJson()).toList(),
      };
}
