import 'package:dio/dio.dart';

/// Python backend yoki tarmoq xatolarini standartlashtirilgan ko'rinishda ushlash
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalData;

  const ApiException({
    required this.message,
    this.statusCode,
    this.originalData,
  });

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';

  /// DioError dan qulay ApiException yaratish
  factory ApiException.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: "Server bilan ulanish vaqti tugadi. Internet aloqasini tekshiring.",
          statusCode: 408,
        );

      case DioExceptionType.badResponse:
        final status = dioException.response?.statusCode;
        final data = dioException.response?.data;
        String errorMessage = _extractErrorMessage(data, status);

        return ApiException(
          message: errorMessage,
          statusCode: status,
          originalData: data,
        );

      case DioExceptionType.cancel:
        return const ApiException(
          message: "So'rov bekor qilindi.",
        );

      case DioExceptionType.connectionError:
        return const ApiException(
          message: "Python backend serveriga ulanib bo'lmadi. Server yoqilganligini tekshiring.",
        );

      case DioExceptionType.badCertificate:
        return const ApiException(
          message: "Xavfsizlik sertifikati xatosi.",
        );

      case DioExceptionType.unknown:
      default:
        return ApiException(
          message: dioException.message ?? "Noma'lum xatolik yuz berdi.",
        );
    }
  }

  /// FastAPI / Django dan kelgan xatolik xabarlarini tahlil qilish
  static String _extractErrorMessage(dynamic data, int? statusCode) {
    if (data is Map<String, dynamic>) {
      // FastAPI odatda `{"detail": "Xato matni"}` yoki `{"detail": [{"msg": "..."}]}` qaytaradi
      if (data.containsKey('detail')) {
        final detail = data['detail'];
        if (detail is String) return detail;
        if (detail is List && detail.isNotEmpty) {
          final first = detail.first;
          if (first is Map && first.containsKey('msg')) {
            return first['msg'].toString();
          }
          return detail.join(', ');
        }
      }

      // Django REST `{"error": "..."}` yoki `{"message": "..."}`
      if (data.containsKey('error') && data['error'] is String) {
        return data['error'] as String;
      }
      if (data.containsKey('message') && data['message'] is String) {
        return data['message'] as String;
      }

      // Django field validation error: `{"phone": ["Invalid phone number"]}`
      final firstKey = data.keys.firstOrNull;
      if (firstKey != null) {
        final val = data[firstKey];
        if (val is List && val.isNotEmpty) {
          return '$firstKey: ${val.first}';
        }
      }
    }

    switch (statusCode) {
      case 400:
        return "Noto'g'ri so'rov yuborildi (400).";
      case 401:
        return "Autentifikatsiya muddati tugagan yoki ruxsat yo'q (401).";
      case 403:
        return "Ushbu amalni bajarishga huquqingiz yo'q (403).";
      case 404:
        return "So'ralgan ma'lumot serverda topilmadi (404).";
      case 422:
        return "Yuborilgan ma'lumotlar formati noto'g'ri (FastAPI 422).";
      case 500:
        return "Serverda ichki xatolik yuz berdi (Python backend 500).";
      default:
        return "Server javob berishda xatolik yuz berdi ($statusCode).";
    }
  }
}

