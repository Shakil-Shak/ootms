import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _preferences;
  

  static Future initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String? getString(String key) {
    return _preferences?.getString(key) ?? "";
  }

  Future<void> removeString(String key) async {
    await _preferences?.remove(key);
  }

  Future<void> clearAll() async {
    await _preferences?.clear();
  }
}