import 'datum.dart';

class Getresponse {
  int? code;
  String? status;
  List<Datum>? data;

  Getresponse({this.code, this.status, this.data});

  factory Getresponse.fromJson(Map<String, dynamic> json) => Getresponse(
        code: json['code'] as int?,
        status: json['status'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
