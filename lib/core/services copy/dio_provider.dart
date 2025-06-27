import 'package:dio/dio.dart';

// class PrayerApi {
//   final Dio _dio = Dio();

//   Future<Map<String, String>> getPrayerTimes({
//     required double latitude,
//     required double longitude,
//     required DateTime date,
//   }) async {
//     final formattedDate = "${date.day}-${date.month}-${date.year}";

//     try {
//       final response = await _dio.get(
//         'http://api.aladhan.com/v1/timings/$formattedDate',
//         queryParameters: {
//           'latitude': latitude,
//           'longitude': longitude,
//           'method': 5,
//         },
//       );

//       final data = response.data['data']['timings'];
//       return {
//         'Fajr': data['Fajr'],
//         'Zuhr': data['Dhuhr'],
//         'Asr': data['Asr'],
//         'Maghrib': data['Maghrib'],
//         'Isha': data['Isha'],
//       };
//     } catch (e) {
//       print('Error fetching prayer times: $e');
//       return {
//         'Fajr': '--',
//         'Zuhr': '--',
//         'Asr': '--',
//         'Maghrib': '--',
//         'Isha': '--',
//       };
//     }
//   }
// }
class DioProvider {
  static late Dio _dio;

  static init() {
    _dio = Dio();
  }

  static Future<Response> get(
      {required String endpoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) {
    return _dio.get(endpoint,
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
  }

  static Future<Response> post(
      {required String endpoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) {
    return _dio.post(endpoint,
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
  }

  static Future<Response> put(
      {required String endpoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) {
    return _dio.put(endpoint,
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
  }

  static Future<Response> delete(
      {required String endpoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) {
    return _dio.delete(endpoint,
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
  }
}
