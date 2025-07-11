import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorageshared {
  static late SharedPreferences prefs;
  static String tokenkey = 'token';
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static cacheData(String key, dynamic value) async {
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  static getCachedData(String key) {
    return prefs.get(key);
  }

  static removeCachedData(String key) {
    prefs.remove(key);
  }
}
