import 'package:humo_kids/core/api/api_client.dart';
import 'package:humo_kids/core/api/api_endpoints.dart';

/// Bildirishnomalar servisi
class NotificationService {
  final ApiClient _client = ApiClient.instance;

  /// Bildirishnomalar ro'yxatini olish
  /// Python backend: `GET /api/v1/notifications`
  Future<List<Map<String, dynamic>>> getNotifications() async {
    final response = await _client.get(ApiEndpoints.notifications);
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    return [];
  }

  /// Bildirishnomani o'qilgan deb belgilash
  /// Python backend: `POST /api/v1/notifications/{id}/read`
  Future<void> markAsRead(String id) async {
    await _client.post(ApiEndpoints.markNotificationRead(id));
  }

  /// Barcha bildirishnomalarni o'qilgan deb belgilash
  /// Python backend: `POST /api/v1/notifications/read-all`
  Future<void> markAllAsRead() async {
    await _client.post(ApiEndpoints.markAllNotificationsRead);
  }
}

