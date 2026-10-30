import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/payments/screens/card_empty_screen.dart';
import 'package:humo_kids/features/payments/screens/payment_receipt_screen.dart';
import 'package:humo_kids/features/payments/screens/payment_error_screen.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({
    super.key,
    this.amount = "600 000 so'm",
    this.month = "Oktabr uchun",
  });

  final String amount;
  final String month;

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  int _selectedCardIndex = 0; // 0: Humo 4821, 1: Uzcard 7164
  int _selectedBrand = 1; // 0: Uzcard, 1: Humo, 2: Visa, 3: Mastercard

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }

  void _onPay() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Color(0xFF16A34A),
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "To'lov muvaffaqiyatli!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${widget.amount} muvaffaqiyatli to'landi. Kvitansiya shakllantirildi.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: AppColors.grayText),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaymentReceiptScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Kvitansiyani ko'rish",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context, true);
              },
              child: const Text(
                "Bosh sahifaga qaytish",
                style: TextStyle(color: AppColors.grayText, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddCard() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Yangi bank kartasi muvaffaqiyatli qo'shildi!"),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
    _cardNumberController.clear();
    _expiryController.clear();
    _cvvController.clear();
    _cardNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.darkText),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFDC2626),
            ),
            tooltip: "To'lov xatosi holati (16-ekran)",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentErrorScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.credit_card_off_outlined,
              color: AppColors.primary,
            ),
            tooltip: "Karta hali qo'shilmagan holat",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CardEmptyScreen()),
              );
            },
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mening kartalarim",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "${widget.amount} · ${widget.month}",
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.grayText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section: Saqlangan kartalar
                  const Text(
                    "Saqlangan kartalar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Card 1: Humo 4821 (Selected)
                  GestureDetector(
                    onTap: () => setState(() => _selectedCardIndex = 0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F2C6B), Color(0xFF1E3A8A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0F2C6B)
                                .withValues(alpha: 0.25),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Asosiy karta",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "HUMO",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            "••••  ••••  ••••  4821",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "DILNOZA A.",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                              if (_selectedCardIndex == 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "Tanlangan",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F2C6B),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Card 2: Uzcard 7164
                  GestureDetector(
                    onTap: () => setState(() => _selectedCardIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _selectedCardIndex == 1
                              ? AppColors.primary
                              : const Color(0xFFEDF2F7),
                          width: _selectedCardIndex == 1 ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.credit_card_rounded,
                              color: AppColors.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Uzcard · •••• 7164",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkText,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Saqlangan karta",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.grayText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedCardIndex == 1
                                    ? AppColors.primary
                                    : const Color(0xFFCBD5E1),
                                width: 2,
                              ),
                              color: _selectedCardIndex == 1
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                            child: _selectedCardIndex == 1
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Pay button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _onPay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Tanlangan karta bilan to'lash",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Button to simulate payment error state (16-ekran)
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentErrorScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        size: 18,
                        color: Color(0xFFDC2626),
                      ),
                      label: const Text(
                        "To'lov xatosi holatini ko'rish (16-ekran)",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFDC2626),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFECDD3)),
                        backgroundColor: const Color(0xFFFFF1F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Section: Yangi karta qo'shish
                  const Text(
                    "Yangi karta qo'shish",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Card brand pills
                  Row(
                    children: [
                      _BrandPill(
                        label: 'Uzcard',
                        isSelected: _selectedBrand == 0,
                        onTap: () => setState(() => _selectedBrand = 0),
                      ),
                      const SizedBox(width: 8),
                      _BrandPill(
                        label: 'Humo',
                        isSelected: _selectedBrand == 1,
                        onTap: () => setState(() => _selectedBrand = 1),
                      ),
                      const SizedBox(width: 8),
                      _BrandPill(
                        label: 'Visa',
                        isSelected: _selectedBrand == 2,
                        onTap: () => setState(() => _selectedBrand = 2),
                      ),
                      const SizedBox(width: 8),
                      _BrandPill(
                        label: 'Mastercard',
                        isSelected: _selectedBrand == 3,
                        onTap: () => setState(() => _selectedBrand = 3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Karta raqami
                  const Text(
                    "Karta raqami",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "•••• •••• •••• ••••",
                      prefixIcon: const Icon(
                        Icons.credit_card_rounded,
                        color: AppColors.primary,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Row: Amal qilish muddati & CVV
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Amal qilish muddati",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _expiryController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                hintText: "OO / YY",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "CVV · Visa / Mastercard",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "•••",
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Karta nomi
                  const Text(
                    "Karta nomi",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _cardNameController,
                    decoration: InputDecoration(
                      hintText: "Masalan, oilaviy karta",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // + Kartani qo'shish button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _onAddCard,
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      label: const Text(
                        "Kartani qo'shish",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEFF6FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Security notice
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFF16A34A),
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Karta ma'lumotlari himoyalangan. CVV saqlanmaydi. Tasdiqlash kodi bank orqali yuboriladi.",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grayText,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandPill extends StatelessWidget {
  const _BrandPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.primary : AppColors.darkText,
          ),
        ),
      ),
    );
  }
}
