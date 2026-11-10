import 'package:humo_kids/core/api/api_client.dart';
import 'package:humo_kids/core/api/api_endpoints.dart';
import 'package:humo_kids/core/api/models/user_model.dart';
import 'package:humo_kids/core/api/token_storage.dart';

/// Python backend Autentifikatsiya servisi
class AuthService {
  final ApiClient _client = ApiClient.instance;

  /// Telefon raqamiga OTP SMS yuborish
  /// Python backend: `POST /api/v1/auth/send-otp`
  /// Body: `{"phone": "+998901234567"}`
  Future<bool> sendOtp(String phone) async {
    final response = await _client.post(
      ApiEndpoints.sendOtp,
      data: {'phone': phone},
    );
    return response['success'] as bool? ?? true;
  }

  /// OTP kodini tekshirish va JWT token olish
  /// Python backend: `POST /api/v1/auth/verify-otp`
  /// Body: `{"phone": "+998901234567", "code": "1234"}`
  /// Qaytishi: `{"access_token": "...", "refresh_token": "...", "user": {...}}`
  Future<AuthTokenModel> verifyOtp({
    required String phone,
    required String code,
  }) async {
    final response = await _client.post(
      ApiEndpoints.verifyOtp,
      data: {
        'phone': phone,
        'code': code,
      },
    );

    final tokenModel = AuthTokenModel.fromJson(response);

    // Tokenlarni saqlaymiz
    await TokenStorage.saveTokens(
      accessToken: tokenModel.accessToken,
      refreshToken: tokenModel.refreshToken,
    );

    if (tokenModel.user != null) {
      await TokenStorage.saveUserData(
        id: tokenModel.user!.id,
        name: tokenModel.user!.name,
        phone: tokenModel.user!.phone,
        hasPin: tokenModel.user!.hasPin,
      );
    }

    return tokenModel;
  }

  /// Yangi PIN-kod o'rnatish
  /// Python backend: `POST /api/v1/auth/set-pin`
  /// Body: `{"pin": "1234"}`
  Future<bool> setPin(String pin) async {
    final response = await _client.post(
      ApiEndpoints.setPin,
      data: {'pin': pin},
    );
    await TokenStorage.saveUserData(hasPin: true);
    return response['success'] as bool? ?? true;
  }

  /// PIN-kod orqali kirish
  /// Python backend: `POST /api/v1/auth/verify-pin`
  /// Body: `{"pin": "1234"}`
  Future<bool> verifyPin(String pin) async {
    final response = await _client.post(
      ApiEndpoints.verifyPin,
      data: {'pin': pin},
    );
    return response['valid'] as bool? ?? true;
  }

  /// Hozirgi foydalanuvchi profilini yuklash
  /// Python backend: `GET /api/v1/auth/me`
  Future<UserModel> getCurrentUser() async {
    final response = await _client.get(ApiEndpoints.userProfile);
    return UserModel.fromJson(response);
  }

  /// Profil ma'lumotlarini tahrirlash
  /// Python backend: `PUT /api/v1/auth/profile/update`
  Future<UserModel> updateProfile({
    required String name,
    required String phone,
  }) async {
    final response = await _client.put(
      ApiEndpoints.updateProfile,
      data: {
        'name': name,
        'phone': phone,
      },
    );
    final user = UserModel.fromJson(response);
    await TokenStorage.saveUserData(name: user.name, phone: user.phone);
    return user;
  }

  /// Ilovadan chiqish (Logout)
  /// Python backend: `POST /api/v1/auth/logout`
  Future<void> logout() async {
    try {
      await _client.post(ApiEndpoints.logout);
    } catch (_) {
      // Serverga ulanib bo'lmasa ham lokal tokenni tozalaymiz
    } finally {
      await TokenStorage.clearAll();
    }
  }
}

