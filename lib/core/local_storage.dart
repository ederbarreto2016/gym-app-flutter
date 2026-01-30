import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _activeGymIdKey = 'activeGymId';

  Future<void> setActiveGymId(String gymId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeGymIdKey, gymId);
  }

  Future<String?> getActiveGymId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activeGymIdKey);
  }

  Future<void> clearActiveGymId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeGymIdKey);
  }
}
