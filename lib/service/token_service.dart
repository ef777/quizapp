import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static const String _keyToken = 'token';
  static const String _activeToken = 'active';
  static const String _bareerToken = '';
  static const String _userId = '0';
  static const String _role = '';
  static const String login = '0';
  static const String role123 = '0';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }

  Future<void> saveloginKey(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  Future<String?> getloginKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  Future<void> removeloginKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }

  Future<void> saveActive(String active) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeToken, active);
  }

  Future<String?> getActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activeToken);
  }

  Future<void> saveLogin(String? token, String? userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bareerToken, token ?? "");
    await prefs.setString(_userId, userId ?? "");
  }

  Future<void> saveRole(String? role) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(role123, role ?? "");
  }

  Future<String?> getBareerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bareerToken);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userId);
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(role123);
  }

  Future<void> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(login);
  }

  Future<void> removeBarrerToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_bareerToken);
    await prefs.remove(_role);
    await prefs.remove(_userId);
    await prefs.remove(_activeToken);
    await prefs.remove(login);
  }
}
