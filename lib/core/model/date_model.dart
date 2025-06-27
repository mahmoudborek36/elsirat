import 'package:hive/hive.dart';

part 'date_model.g.dart';

@HiveType(typeId: 1)
class DateModel {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final String fajr;
  @HiveField(2)
  final String? sunrise;
  @HiveField(3)
  final String dhuhr;
  @HiveField(4)
  final String asr;
  @HiveField(5)
  final String maghrib;
  @HiveField(6)
  final String isha;
  @HiveField(7)
  final bool isCompelete;

  DateModel({
    required this.date,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.isCompelete,
  });

  DateModel copyWith({
    String? date,
    String? fajr,
    String? sunrise,
    String? dhuhr,
    String? asr,
    String? maghrib,
    String? isha,
    bool? isCompelete,
  }) {
    return DateModel(
      date: date ?? this.date,
      fajr: fajr ?? this.fajr,
      sunrise: sunrise ?? this.sunrise,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
      isCompelete: isCompelete ?? this.isCompelete,
    );
  }
}
