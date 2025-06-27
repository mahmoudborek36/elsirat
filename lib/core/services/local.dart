import 'package:elsirat/core/model/date_model.dart';
import 'package:hive/hive.dart';

class AppLocalStorege {
  static Box? myBox;
  static Box<DateModel>? dateBox;
  static String islog = "islog";
  static String isreg = "isreg";
  static String isdone = "isdone";
  static String isgoogle = "isgoogle";

  static init() async {
    myBox = await Hive.openBox("mybox");
    dateBox = await Hive.openBox<DateModel>("datebox");
  }

  static cachData(String key, dynamic value) async {
    await myBox?.put(key, value);
  }

  static getData(String key) {
    return myBox?.get(key);
  }

  static cachTaskData(String key, DateModel value) async {
    await dateBox?.put(key, value);
  }

  static DateModel? getTaskData(String key) {
    return dateBox?.get(key);
  }

  static removedata(String key) {
    return myBox?.delete(key);
  }
}
