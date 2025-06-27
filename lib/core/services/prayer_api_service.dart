import 'package:dio/dio.dart';

class PrayerApiService {
  final Dio _dio = Dio();

  Future<Map<String, DateTime>> fetchPrayerTimes({
    required double latitude,
    required double longitude,
  }) async {
    final response = await _dio.get(
      'https://api.aladhan.com/v1/timings',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'method': 5, // طريقة حساب الصلاة (مثلاً: أم القرى)
      },
    );

    final data = response.data['data']['timings'];
    final date = DateTime.now();

    // نحول المواقيت إلى DateTime
    Map<String, DateTime> prayerTimes = {};
    data.forEach((key, value) {
      final timeParts = (value as String).split(':');
      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = int.tryParse(timeParts[1]) ?? 0;
      prayerTimes[key] =
          DateTime(date.year, date.month, date.day, hour, minute);
    });

    return prayerTimes;
  }
}
