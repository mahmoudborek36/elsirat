import 'english.dart';

class GetAllOfAzkarData {
  List<English>? english;

  GetAllOfAzkarData({this.english});

  factory GetAllOfAzkarData.fromJson(Map<String, dynamic> json) {
    return GetAllOfAzkarData(
      english: (json['English'] as List<dynamic>?)
          ?.map((e) => English.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'English': english?.map((e) => e.toJson()).toList(),
      };
}
