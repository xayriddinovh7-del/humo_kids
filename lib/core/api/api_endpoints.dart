/// Python backend (FastAPI / Django REST) uchun barcha endpointlar ro'yxati
class ApiEndpoints {
  ApiEndpoints._();

  // ─── AUTH (AUTENTIFIKATSIYA) ──────────────────────────
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh-token';
  static const String setPin = '/auth/set-pin';
  static const String verifyPin = '/auth/verify-pin';
  static const String logout = '/auth/logout';
  static const String userProfile = '/auth/me';
  static const String updateProfile = '/auth/profile/update';

  // ─── FARZANDLAR VA BOG'CHA MA'LUMOTLARI ────────────────
  static const String childrenList = '/children';
  static String childDetails(String childId) => '/children/$childId';
  static String dailyReport(String childId) => '/children/$childId/daily-report';
  static String activities(String childId) => '/children/$childId/activities';
  static String foodMenu(String childId) => '/children/$childId/food-menu';
  static String momentsGallery(String childId) => '/children/$childId/moments';

  // ─── TO'LOVLAR VA KVITANSIYALAR ───────────────────────
  static const String invoices = '/payments/invoices';
  static const String cards = '/payments/cards';
  static const String addCard = '/payments/cards/add';
  static String deleteCard(String cardId) => '/payments/cards/$cardId';
  static const String makePayment = '/payments/pay';
  static String paymentReceipt(String receiptId) => '/payments/receipts/$receiptId';

  // ─── BILDIRISHNOMALAR (NOTIFICATIONS) ─────────────────
  static const String notifications = '/notifications';
  static String markNotificationRead(String id) => '/notifications/$id/read';
  static const String markAllNotificationsRead = '/notifications/read-all';

  // ─── XABARLAR VA CHAT (MESSAGES) ──────────────────────
  static const String chats = '/messages/chats';
  static String chatMessages(String chatId) => '/messages/chats/$chatId/messages';
  static String sendMessage(String chatId) => '/messages/chats/$chatId/send';
}

