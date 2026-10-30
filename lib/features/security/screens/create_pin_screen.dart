import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';
import 'package:humo_kids/shared/widgets/num_pad.dart';
import 'package:humo_kids/shared/widgets/pin_dots.dart';
import 'package:humo_kids/features/security/screens/confirm_pin_screen.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  static const int _pinLength = 4;
  final List<String> _digits = [];

  void _onDigit(String d) {
    if (_digits.length >= _pinLength) return;
    setState(() => _digits.add(d));

    if (_digits.length == _pinLength) {
      final pin = _digits.join();
      Future.delayed(const Duration(milliseconds: 160), () {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ConfirmPinScreen(pin: pin)),
        ).then((_) {
          if (mounted) setState(() => _digits.clear());
        });
      });
    }
  }

  void _onBackspace() {
    if (_digits.isEmpty) return;
    setState(() => _digits.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Hisob xavfsizligi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),
        leading: const BackButton(color: AppColors.darkText),
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              children: [
                // Scrollable top content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          const HumoLogo(iconSize: 20, fontSize: 16),
                          const SizedBox(height: 12),
                          // Shield badge
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlueBg,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            "PIN-kod yarating",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Ilovangizni himoyalash uchun 4 xonali maxfiy kod\no'ylab toping.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grayText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 18),
                          // 4 Dots
                          PinDots(length: _pinLength, filled: _digits.length),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                // Docked bottom keypad and Face ID card
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 6, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NumPad(
                        onDigit: _onDigit,
                        onBackspace: _onBackspace,
                        keyHeight: 46,
                      ),
                      const SizedBox(height: 12),
                      const _FaceIdCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FaceIdCard extends StatelessWidget {
  const _FaceIdCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.face_retouching_natural,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Face ID bilan tezkor kirish",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Keyinroq profil orqali ham yoqish\nmumkin",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.grayText,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "Ixtiyoriy",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.grayText,
            ),
          ),
        ],
      ),
    );
  }
}
