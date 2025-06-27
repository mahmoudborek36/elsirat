import 'content.dart';

class GetAzkarData {
  String? title;
  List<Content>? content;

  GetAzkarData({this.title, this.content});

  factory GetAzkarData.fromJson(Map<String, dynamic> json) => GetAzkarData(
        title: json['title'] as String?,
        content: (json['content'] as List<dynamic>?)
            ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content?.map((e) => e.toJson()).toList(),
      };
}
