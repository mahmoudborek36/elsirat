import 'dart:developer';

import 'package:elsirat/core/services%20copy/dio_provider.dart';
import 'package:elsirat/fearture/prayTime/data/serices/getresponse/getresponse.dart';

class GetdateRepo {
  static Future<Getresponse?> getdate(
    double latitude,
    double longitude,
    int month,
    int year,
  ) async {
    try {
      var response = await DioProvider.get(
          endpoint: 'https://api.aladhan.com/v1/calendar',
          params: {
            'latitude': 30.0444,
            'longitude': 31.2357,
            'method': 5,
            'month': month,
            'year': year,
          });

      if (response.statusCode == 200) {
        return Getresponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
      log(e.toString());
      return null;
    }
  }
}
