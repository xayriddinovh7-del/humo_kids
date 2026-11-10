import 'package:flutter/foundation.dart';

/// Python backend bilan ulanish uchun barcha konfiguratsiyalar
class ApiConfig {
  ApiConfig._();

  /// Hozirgi ishlatilayotgan Base URL
  ///
  /// Python backend odatda `http://localhost:8000` yoki `http://0.0.0.0:8000` da ishga tushiriladi:
  /// - Android Emulator: `http://10.0.2.2:8000/api/v1` (10.0.2.2 emulyatordan kompyuter localhost-ga ko'prik)
  /// - iOS Simulator: `http://127.0.0.1:8000/api/v1`
  /// - Real telefon (Wi-Fi orqali): Kompyuteringiz mahalliy IP manzili, masalan: `http://192.168.1.100:8000/api/v1`
  /// - Web va Desktop: `http://localhost:8000/api/v1`
  /// - Production server: `https://api.humokids.uz/api/v1`
  static String get defaultBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000/api/v1';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // Android emulyator uchun standart host
        return 'http://10.0.2.2:8000/api/v1';
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 'http://127.0.0.1:8000/api/v1';
      default:
        return 'http://localhost:8000/api/v1';
    }
  }

  /// Foydalanuvchi yoki sozlamalar orqali o'zgartiriladigan dinamik Base URL
  static String _customBaseUrl = '';

  static String get baseUrl =>
      _customBaseUrl.isNotEmpty ? _customBaseUrl : defaultBaseUrl;

  /// Real telefon bilan sinovdan o'tkazishda kompyuter IP manzilini o'rnatish uchun:
  /// Masalan: `ApiConfig.setBaseUrl('http://192.168.1.5:8000/api/v1');`
  static void setBaseUrl(String url) {
    _customBaseUrl = url;
  }

  /// Timeout vaqt chegaralari (millisekundda)
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 20);

  /// Standart HTTP sarlavhalari
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Client-Platform': defaultTargetPlatform.name,
      };
}

