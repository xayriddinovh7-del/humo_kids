class CardModel {
  final String id;
  final String cardNumber; // Masalan: "8600 **** **** 1234"
  final String cardHolder;
  final String expireDate; // "12/28"
  final String type; // "humo", "uzcard", "visa", "mastercard"
  final bool isDefault;

  const CardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expireDate,
    required this.type,
    this.isDefault = false,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id']?.toString() ?? '',
      cardNumber: json['card_number'] as String? ?? '',
      cardHolder: json['card_holder'] as String? ?? '',
      expireDate: json['expire_date'] as String? ?? '',
      type: json['type'] as String? ?? 'humo',
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'card_number': cardNumber,
        'card_holder': cardHolder,
        'expire_date': expireDate,
        'type': type,
        'is_default': isDefault,
      };
}

class InvoiceModel {
  final String id;
  final String childId;
  final String childName;
  final String month; // "Oktabr 2026"
  final double amount; // 600000.0
  final String amountFormatted; // "600 000 so'm"
  final String status; // "pending", "paid", "failed"
  final String deadline; // "28-oktabr 2026"
  final String? receiptId;

  const InvoiceModel({
    required this.id,
    required this.childId,
    required this.childName,
    required this.month,
    required this.amount,
    required this.amountFormatted,
    required this.status,
    required this.deadline,
    this.receiptId,
  });

  bool get isPaid => status == 'paid';

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id']?.toString() ?? '',
      childId: json['child_id']?.toString() ?? '',
      childName: json['child_name'] as String? ?? '',
      month: json['month'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      amountFormatted: json['amount_formatted'] as String? ?? "0 so'm",
      status: json['status'] as String? ?? 'pending',
      deadline: json['deadline'] as String? ?? '',
      receiptId: json['receipt_id'] as String?,
    );
  }
}

