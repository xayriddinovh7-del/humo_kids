import 'package:humo_kids/core/api/api_client.dart';
import 'package:humo_kids/core/api/api_endpoints.dart';
import 'package:humo_kids/core/api/models/payment_model.dart';

/// To'lovlar, bank kartalari va invoyslar servisi
class PaymentService {
  final ApiClient _client = ApiClient.instance;

  /// Invoyslar (to'lov talabnomalari) ro'yxati
  /// Python backend: `GET /api/v1/payments/invoices?child_id=...`
  Future<List<InvoiceModel>> getInvoices({String? childId}) async {
    final response = await _client.get(
      ApiEndpoints.invoices,
      queryParameters: childId != null ? {'child_id': childId} : null,
    );
    if (response is List) {
      return response.map((item) => InvoiceModel.fromJson(item)).toList();
    }
    return [];
  }

  /// Bog'langan bank kartalari ro'yxati
  /// Python backend: `GET /api/v1/payments/cards`
  Future<List<CardModel>> getCards() async {
    final response = await _client.get(ApiEndpoints.cards);
    if (response is List) {
      return response.map((item) => CardModel.fromJson(item)).toList();
    }
    return [];
  }

  /// Yangi bank kartasini qo'shish
  /// Python backend: `POST /api/v1/payments/cards/add`
  /// Body: `{"card_number": "8600...", "expire_date": "12/28", "card_holder": "..."}`
  Future<CardModel> addCard({
    required String cardNumber,
    required String expireDate,
    required String cardHolder,
  }) async {
    final response = await _client.post(
      ApiEndpoints.addCard,
      data: {
        'card_number': cardNumber,
        'expire_date': expireDate,
        'card_holder': cardHolder,
      },
    );
    return CardModel.fromJson(response);
  }

  /// Kartani o'chirish
  /// Python backend: `DELETE /api/v1/payments/cards/{card_id}`
  Future<bool> deleteCard(String cardId) async {
    final response = await _client.delete(ApiEndpoints.deleteCard(cardId));
    return response['success'] as bool? ?? true;
  }

  /// To'lovni amalga oshirish
  /// Python backend: `POST /api/v1/payments/pay`
  /// Body: `{"invoice_id": "...", "card_id": "...", "provider": "Payme"}`
  Future<Map<String, dynamic>> pay({
    required String invoiceId,
    String? cardId,
    String? provider,
    double? amount,
  }) async {
    final response = await _client.post(
      ApiEndpoints.makePayment,
      data: {
        'invoice_id': invoiceId,
        'card_id': cardId,
        'provider': provider,
        'amount': amount,
      },
    );
    return response is Map<String, dynamic> ? response : {'success': true};
  }

  /// Kvitansiya ma'lumotlarini olish
  /// Python backend: `GET /api/v1/payments/receipts/{receipt_id}`
  Future<Map<String, dynamic>> getReceipt(String receiptId) async {
    final response = await _client.get(ApiEndpoints.paymentReceipt(receiptId));
    return response is Map<String, dynamic> ? response : {};
  }
}

