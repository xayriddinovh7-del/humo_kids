import 'package:humo_kids/core/api/api_client.dart';
import 'package:humo_kids/core/api/api_endpoints.dart';

/// O'qituvchi va bog'cha ma'muriyati bilan chat servisi
class ChatService {
  final ApiClient _client = ApiClient.instance;

  /// Chatlar ro'yxati
  /// Python backend: `GET /api/v1/messages/chats`
  Future<List<Map<String, dynamic>>> getChats() async {
    final response = await _client.get(ApiEndpoints.chats);
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    return [];
  }

  /// Chat xabarlar tarixi
  /// Python backend: `GET /api/v1/messages/chats/{chatId}/messages`
  Future<List<Map<String, dynamic>>> getMessages(String chatId) async {
    final response = await _client.get(ApiEndpoints.chatMessages(chatId));
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    return [];
  }

  /// Yangi xabar yuborish
  /// Python backend: `POST /api/v1/messages/chats/{chatId}/send`
  /// Body: `{"text": "Salom..."}`
  Future<Map<String, dynamic>> sendMessage({
    required String chatId,
    required String text,
  }) async {
    final response = await _client.post(
      ApiEndpoints.sendMessage(chatId),
      data: {'text': text},
    );
    return response is Map<String, dynamic> ? response : {};
  }
}

