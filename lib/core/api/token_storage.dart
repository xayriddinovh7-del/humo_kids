import 'package:shared_preferences/shared_preferences.dart';

/// Foydalanuvchi JWT tokenlari va sessiya ma'lumotlarini saqlash
class TokenStorage {
  static const String _keyAccessToken = 'auth_access_token';
  static const String _keyRefreshToken = 'auth_refresh_token';
  static const String _keyUserId = 'auth_user_id';
  static const String _keyUserName = 'auth_user_name';
  static const String _keyUserPhone = 'auth_user_phone';
  static const String _keyHasPin = 'auth_has_pin';

  static SharedPreferences? _prefs;

  /// SharedPreferences ni ishga tushirish (main.dart da chaqirish mumkin)
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ─── Tokenlar ───
  static Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    final prefs = await _getPrefs();
    await prefs.setString(_keyAccessToken, accessToken);
    if (refreshToken != null) {
      await prefs.setString(_keyRefreshToken, refreshToken);
    }
  }

  static Future<String?> getAccessToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_keyAccessToken);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_keyRefreshToken);
  }

  static Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // ─── Foydalanuvchi ma'lumotlari ───
  static Future<void> saveUserData({
    String? id,
    String? name,
    String? phone,
    bool? hasPin,
  }) async {
    final prefs = await _getPrefs();
    if (id != null) await prefs.setString(_keyUserId, id);
    if (name != null) await prefs.setString(_keyUserName, name);
    if (phone != null) await prefs.setString(_keyUserPhone, phone);
    if (hasPin != null) await prefs.setBool(_keyHasPin, hasPin);
  }

  static Future<String?> getUserName() async {
    final prefs = await _getPrefs();
    return prefs.getString(_keyUserName);
  }

  static Future<String?> getUserPhone() async {
    final prefs = await _getPrefs();
    return prefs.getString(_keyUserPhone);
  }

  static Future<bool> hasPinCode() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyHasPin) ?? false;
  }

  // ─── Chiqish (Logout) / Tozalash ───
  static Future<void> clearAll() async {
    final prefs = await _getPrefs();
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyRefreshToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserPhone);
    await prefs.remove(_keyHasPin);
  }
}

