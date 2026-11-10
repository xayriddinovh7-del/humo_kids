import 'package:humo_kids/core/api/api_client.dart';
import 'package:humo_kids/core/api/api_endpoints.dart';
import 'package:humo_kids/core/api/models/child_model.dart';

/// Farzandlar, hisobotlar va bog'cha ma'lumotlari servisi
class ChildrenService {
  final ApiClient _client = ApiClient.instance;

  /// Ota-onaga biriktirilgan barcha farzandlar ro'yxati
  /// Python backend: `GET /api/v1/children`
  Future<List<ChildModel>> getChildren() async {
    final response = await _client.get(ApiEndpoints.childrenList);
    if (response is List) {
      return response.map((item) => ChildModel.fromJson(item)).toList();
    }
    return [];
  }

  /// Farzandning kunlik hisoboti (kayfiyati, uyqusi, ovqatlanishi, mashg'ulotlari)
  /// Python backend: `GET /api/v1/children/{id}/daily-report?date=2026-10-23`
  Future<DailyReportModel> getDailyReport(String childId, {String? date}) async {
    final response = await _client.get(
      ApiEndpoints.dailyReport(childId),
      queryParameters: date != null ? {'date': date} : null,
    );
    return DailyReportModel.fromJson(response);
  }

  /// Kunlik taomnoma (ovqatlanish menyusi)
  /// Python backend: `GET /api/v1/children/{id}/food-menu`
  Future<List<FoodMenuItem>> getFoodMenu(String childId) async {
    final response = await _client.get(ApiEndpoints.foodMenu(childId));
    if (response is List) {
      return response.map((item) => FoodMenuItem.fromJson(item)).toList();
    }
    return [];
  }

  /// Kunlik mashg'ulotlar jadvali
  /// Python backend: `GET /api/v1/children/{id}/activities`
  Future<List<Map<String, dynamic>>> getActivities(String childId) async {
    final response = await _client.get(ApiEndpoints.activities(childId));
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    return [];
  }

  /// Fotogalereya (Lahzalar) rasmlari
  /// Python backend: `GET /api/v1/children/{id}/moments`
  Future<List<Map<String, dynamic>>> getMoments(String childId) async {
    final response = await _client.get(ApiEndpoints.momentsGallery(childId));
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    return [];
  }
}

