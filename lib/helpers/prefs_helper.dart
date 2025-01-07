import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  // static String token = "";
  // static String password = "";
  // static String mentorid = "";
  // static String mentorRegid = "";

  // static getAllData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   token = preferences.getString("mentorToken") ?? "";
  //   password = preferences.getString("password") ?? "";
  //   mentorid = await PrefsHelper.getString("mentorId");
  //   mentorRegid = await PrefsHelper.getString("mentorRegId");
  // }

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(key) ?? "";
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(key) ?? false;
  }

  static Future setString(
    String key,
    value,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}