import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surah.dart';
import 'package:geolocator/geolocator.dart';

class QuranService {
  Future<List<Surah>> loadQuran() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/quran.json');
    final List jsonData = json.decode(jsonString);
    return jsonData.map((s) => Surah.fromJson(s)).toList();
  }
}

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // تأكد إن خدمة الموقع شغالة
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // اطلب صلاحية الوصول
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permission permanently denied');
  }

  // جيب الموقع
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

void getUserLocation() async {
  try {
    Position position = await getCurrentLocation();
    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
  } catch (e) {
    print('Error: $e');
  }
}
