import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static saveTheme(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("light", val);
  }

  static Future<bool> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("light") ?? true;
  }

}