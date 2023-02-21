import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  SPref._internal();
  static final SPref instance = SPref._internal();

  Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }
}
