import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/payments/screens/card_empty_screen.dart';
import 'package:humo_kids/features/payments/screens/payment_receipt_screen.dart';
import 'package:humo_kids/features/payments/screens/payment_error_screen.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';

class SavedCardModel {
  final String brand; // 'Humo', 'Uzcard', 'Visa', 'Mastercard'
  final String cardNumber; // e.g. "••••  ••••  ••••  4821"
  final String last4;
  final String holderName;
  final String expiry;
  final bool isPrimary;

  SavedCardModel({
    required this.brand,
    required this.cardNumber,
    required this.last4,
    required this.holderName,
    required this.expiry,
    this.isPrimary = false,
  });
}

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
  int _selectedCardIndex = 0;
  int _selectedBrand = 1; // 0: Uzcard, 1: Humo, 2: Visa, 3: Mastercard

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();

  final List<SavedCardModel> _savedCards = [
    SavedCardModel(
      brand: 'Humo',
      cardNumber: '••••  ••••  ••••  4821',
      last4: '4821',
      holderName: 'DILNOZA A.',
      expiry: '12/28',
      isPrimary: true,
    ),
    SavedCardModel(
      brand: 'Uzcard',
      cardNumber: '••••  ••••  ••••  7164',
      last4: '7164',
      holderName: 'DILNOZA A.',
      expiry: '09/27',
      isPrimary: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_onFormChanged);
    _expiryController.addListener(_onFormChanged);
    _cvvController.addListener(_onFormChanged);
    _cardNameController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    final clean = _cardNumberController.text.replaceAll(RegExp(r'\D'), '');
    if (clean.startsWith('8600') && _selectedBrand != 0) {
      setState(() => _selectedBrand = 0);
    } else if (clean.startsWith('9860') && _selectedBrand != 1) {
      setState(() => _selectedBrand = 1);
    } else if (clean.startsWith('4') && _selectedBrand != 2) {
      setState(() => _selectedBrand = 2);
    } else if (clean.startsWith('5') && _selectedBrand != 3) {
      setState(() => _selectedBrand = 3);
    } else {
      setState(() {});
    }
  }

  bool get _isCardValid {
    final cleanCard = _cardNumberController.text.replaceAll(RegExp(r'\D'), '');
    if (cleanCard.length != 16) return false;

    final cleanExpiry = _expiryController.text.replaceAll(RegExp(r'\D'), '');
    if (cleanExpiry.length != 4) return false;
    final month = int.tryParse(cleanExpiry.substring(0, 2)) ?? 0;
    if (month < 1 || month > 12) return false;

    // CVV only required for Visa / Mastercard
    if (_selectedBrand == 2 || _selectedBrand == 3) {
      final cleanCvv = _cvvController.text.replaceAll(RegExp(r'\D'), '');
      if (cleanCvv.length < 3) return false;
    }

    return true;
  }

  @override
  void dispose() {
    _cardNumberController.removeListener(_onFormChanged);
    _expiryController.removeListener(_onFormChanged);
    _cvvController.removeListener(_onFormChanged);
    _cardNameController.removeListener(_onFormChanged);
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }

  void _onPay() {
    if (_savedCards.isEmpty) return;
    final selectedCard = _savedCards[_selectedCardIndex];

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
              "${widget.amount} ${selectedCard.brand} (${selectedCard.cardNumber}) orqali to'landi. Kvitansiya shakllantirildi.",
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
    if (!_isCardValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Iltimos, 16 xonali karta raqami va amal qilish muddatini to'liq kiriting."),
          backgroundColor: Color(0xFFEF4444),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final cleanCard = _cardNumberController.text.replaceAll(RegExp(r'\D'), '');
    final last4 = cleanCard.substring(cleanCard.length - 4);
    final brands = ['Uzcard', 'Humo', 'Visa', 'Mastercard'];
    final brand = brands[_selectedBrand];
    final holder = _cardNameController.text.trim().isNotEmpty
        ? _cardNameController.text.trim().toUpperCase()
        : 'DILNOZA A.';
    final expiry = _expiryController.text.trim();

    setState(() {
      _savedCards.add(
        SavedCardModel(
          brand: brand,
          cardNumber: "••••  ••••  ••••  $last4",
          last4: last4,
          holderName: holder,
          expiry: expiry,
          isPrimary: false,
        ),
      );
      _selectedCardIndex = _savedCards.length - 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text("$brand (•••• $last4) muvaffaqiyatli qo'shildi!"),
          ],
        ),
        backgroundColor: const Color(0xFF16A34A),
        duration: const Duration(seconds: 2),
      ),
    );

    _cardNumberController.clear();
    _expiryController.clear();
    _cvvController.clear();
    _cardNameController.clear();
    FocusScope.of(context).unfocus();
  }

  Widget _buildBrandIcon(int brandIndex) {
    switch (brandIndex) {
      case 0: // Uzcard
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF0284C7),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            "UZCARD",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 10,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        );
      case 1: // Humo
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            HumoBirdIcon(size: 15, color: Color(0xFF0F3A8A)),
            SizedBox(width: 4),
            Text(
              "HUMO",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 11,
                color: Color(0xFF0F3A8A),
                letterSpacing: 0.5,
              ),
            ),
          ],
        );
      case 2: // Visa
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F71),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            "VISA",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontSize: 11,
              color: Color(0xFFF7B600),
              letterSpacing: 1.0,
            ),
          ),
        );
      case 3: // Mastercard
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 16,
              child: Stack(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEB001B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    left: 9,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF79E1B).withValues(alpha: 0.95),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              "MC",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 10,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        );
      default:
        return const Icon(Icons.credit_card_rounded,
            color: AppColors.primary, size: 20);
    }
  }

  String _getCardHint(int brandIndex) {
    switch (brandIndex) {
      case 0:
        return "8600 •••• •••• ••••";
      case 1:
        return "9860 •••• •••• ••••";
      case 2:
        return "4000 •••• •••• ••••";
      case 3:
        return "5100 •••• •••• ••••";
      default:
        return "•••• •••• •••• ••••";
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCard = _savedCards.isNotEmpty
        ? _savedCards[_selectedCardIndex.clamp(0, _savedCards.length - 1)]
        : null;

    final isCvvRequired = _selectedBrand == 2 || _selectedBrand == 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.darkText),
        actions: [
          IconButton(
            icon: const Icon(Icons.error_outline_rounded,
                color: Color(0xFFDC2626)),
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

                  // Selected Card Hero View
                  if (selectedCard != null)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: selectedCard.brand == 'Uzcard'
                              ? const [Color(0xFF0284C7), Color(0xFF0369A1)]
                              : selectedCard.brand == 'Visa'
                                  ? const [
                                      Color(0xFF1A1F71),
                                      Color(0xFF0F2C6B)
                                    ]
                                  : selectedCard.brand == 'Mastercard'
                                      ? const [
                                          Color(0xFF1E293B),
                                          Color(0xFF334155)
                                        ]
                                      : const [
                                          Color(0xFF0F2C6B),
                                          Color(0xFF1E3A8A)
                                        ],
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
                            children: [
                              Text(
                                selectedCard.isPrimary
                                    ? "Asosiy karta"
                                    : "Tanlangan karta",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  if (selectedCard.brand == 'Humo') ...[
                                    const HumoBirdIcon(
                                        size: 16, color: Colors.white),
                                    const SizedBox(width: 4),
                                  ],
                                  Text(
                                    selectedCard.brand.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Text(
                            selectedCard.cardNumber,
                            style: const TextStyle(
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
                              Text(
                                selectedCard.holderName,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Amal qilish: ${selectedCard.expiry}",
                                  style: const TextStyle(
                                    fontSize: 11,
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
                  const SizedBox(height: 12),

                  // Other Cards Selector List
                  ...List.generate(_savedCards.length, (index) {
                    final card = _savedCards[index];
                    final isSelected = _selectedCardIndex == index;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedCardIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFFEDF2F7),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: card.brand == 'Humo'
                                    ? const HumoBirdIcon(
                                        size: 16,
                                        color: AppColors.primary,
                                      )
                                    : Icon(
                                        Icons.credit_card_rounded,
                                        color: card.brand == 'Uzcard'
                                            ? const Color(0xFF0284C7)
                                            : AppColors.primary,
                                        size: 22,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${card.brand} · •••• ${card.last4}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    card.isPrimary
                                        ? "Asosiy karta · ${card.holderName}"
                                        : "Saqlangan karta · ${card.holderName}",
                                    style: const TextStyle(
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
                                  color: isSelected
                                      ? AppColors.primary
                                      : const Color(0xFFCBD5E1),
                                  width: 2,
                                ),
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                              child: isSelected
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
                    );
                  }),
                  const SizedBox(height: 8),

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

                  // Card brand pills (Image 2)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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
                  ),
                  const SizedBox(height: 16),

                  // Karta raqami (Image 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Karta raqami",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${_cardNumberController.text.replaceAll(RegExp(r'\D'), '').length} / 16 xona",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _cardNumberController.text
                                      .replaceAll(RegExp(r'\D'), '')
                                      .length ==
                                  16
                              ? const Color(0xFF16A34A)
                              : AppColors.grayText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      _CardNumberFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: _getCardHint(_selectedBrand),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildBrandIcon(_selectedBrand),
                          ],
                        ),
                      ),
                      suffixIcon: _cardNumberController.text
                                  .replaceAll(RegExp(r'\D'), '')
                                  .length ==
                              16
                          ? const Icon(Icons.check_circle_rounded,
                              color: Color(0xFF16A34A), size: 20)
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: _cardNumberController.text
                                      .replaceAll(RegExp(r'\D'), '')
                                      .length ==
                                  16
                              ? const Color(0xFF16A34A)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Row: Amal qilish muddati & CVV (Image 3)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amal qilish muddati
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                _ExpiryDateFormatter(),
                              ],
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
                                  borderSide: BorderSide(
                                    color: _expiryController.text
                                                .replaceAll(RegExp(r'\D'), '')
                                                .length ==
                                            4
                                        ? const Color(0xFF16A34A)
                                        : const Color(0xFFE2E8F0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // CVV (Visa / Mastercard)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isCvvRequired
                                  ? "CVV · Visa / MC"
                                  : "CVV · Kerak emas",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isCvvRequired
                                    ? AppColors.darkText
                                    : AppColors.grayText,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              enabled: isCvvRequired,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              decoration: InputDecoration(
                                hintText: isCvvRequired ? "•••" : "Yo'q",
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  size: 18,
                                  color: isCvvRequired
                                      ? AppColors.primary
                                      : AppColors.grayText,
                                ),
                                filled: true,
                                fillColor: isCvvRequired
                                    ? Colors.white
                                    : const Color(0xFFF1F5F9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: isCvvRequired &&
                                            _cvvController.text.length == 3
                                        ? const Color(0xFF16A34A)
                                        : const Color(0xFFE2E8F0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
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
                    "Karta nomi (ixtiyoriy)",
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

                  // + Kartani qo'shish button (Image 4 - Turns Green when valid!)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: _isCardValid
                            ? const Color(0xFF16A34A) // YASHIL!
                            : const Color(0xFFEFF6FF), // Soft blue
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: _isCardValid
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF16A34A)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _onAddCard,
                        icon: Icon(
                          Icons.add,
                          color: _isCardValid ? Colors.white : AppColors.primary,
                          size: 20,
                        ),
                        label: Text(
                          "Kartani qo'shish",
                          style: TextStyle(
                            color:
                                _isCardValid ? Colors.white : AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
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
            width: isSelected ? 1.5 : 1.0,
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

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final trimmed = digits.length > 16 ? digits.substring(0, 16) : digits;

    final buffer = StringBuffer();
    for (int i = 0; i < trimmed.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(trimmed[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final trimmed = digits.length > 4 ? digits.substring(0, 4) : digits;

    String formatted = '';
    if (trimmed.isNotEmpty) {
      if (trimmed.length == 1) {
        final first = int.tryParse(trimmed[0]) ?? 0;
        if (first > 1) {
          formatted = '0$trimmed / ';
        } else {
          formatted = trimmed;
        }
      } else if (trimmed.length >= 2) {
        final monthStr = trimmed.substring(0, 2);
        int month = int.tryParse(monthStr) ?? 1;
        if (month > 12) month = 12;
        if (month == 0) month = 1;
        final validMonth = month.toString().padLeft(2, '0');

        if (trimmed.length == 2) {
          formatted = '$validMonth / ';
        } else {
          final yearStr = trimmed.substring(2);
          formatted = '$validMonth / $yearStr';
        }
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
