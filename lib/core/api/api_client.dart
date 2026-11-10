import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:humo_kids/core/api/api_config.dart';
import 'package:humo_kids/core/api/api_exception.dart';
import 'package:humo_kids/core/api/token_storage.dart';

/// Python backend bilan barcha HTTP so'rovlarni boshqaruvchi asosiy mijoz
class ApiClient {
  ApiClient._internal() {
    _initDio();
  }

  static final ApiClient instance = ApiClient._internal();
  factory ApiClient() => instance;

  late Dio _dio;

  Dio get dio => _dio;

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: ApiConfig.defaultHeaders,
        responseType: ResponseType.json,
      ),
    );

    // ─── 1. Auth Interceptor: Bearer Token qo'shish ───
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // Agar 401 kelsa, tokenni tozalash yoki refresh qilish
          if (e.response?.statusCode == 401) {
            debugPrint('[API 401] Token muddati tugagan yoki yaroqsiz.');
          }
          return handler.next(e);
        },
      ),
    );

    // ─── 2. Debug Logger Interceptor (Faqat debug rejimda) ───
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          logPrint: (obj) => debugPrint('[API] $obj'),
        ),
      );
    }
  }

  /// Base URL o'zgarganda Dio sozlamasini yangilash
  void updateBaseUrl(String newUrl) {
    ApiConfig.setBaseUrl(newUrl);
    _dio.options.baseUrl = newUrl;
  }

  // ─── GET SO'ROV ──────────────────────────────────────
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  // ─── POST SO'ROV ─────────────────────────────────────
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  // ─── PUT SO'ROV ──────────────────────────────────────
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  // ─── PATCH SO'ROV ────────────────────────────────────
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  // ─── DELETE SO'ROV ───────────────────────────────────
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  // ─── FAYL YUKLASH (MULTIPART FORMDATA) ─────────────────
  Future<dynamic> uploadFile(
    String path, {
    required String filePath,
    required String fileField,
    Map<String, dynamic>? extraFields,
  }) async {
    try {
      final formDataMap = <String, dynamic>{
        fileField: await MultipartFile.fromFile(filePath),
      };
      if (extraFields != null) {
        formDataMap.addAll(extraFields);
      }
      final formData = FormData.fromMap(formDataMap);

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}

