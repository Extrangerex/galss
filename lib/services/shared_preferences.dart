import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// ----------------------------------------------------------
  /// Generic routine to fetch an application preference
  /// ----------------------------------------------------------
  Future<String?> getItem(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(name);
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves an application preference
  /// ----------------------------------------------------------
  Future<bool> setItem(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(name, value);
  }

  Future<Set<String>> getAll() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getKeys();
  }
}
