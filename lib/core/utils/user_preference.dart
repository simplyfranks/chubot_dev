import 'package:shared_preferences/shared_preferences.dart';

class currentUserPreference {
  static const String _firstTimeKey = 'is_first_time';

  // Save status
  static Future<void> setFirstTimeFalse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeKey, false);
  }

  // Check status
  static Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstTimeKey) ?? true;
  }
}
