import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/shared/widgets/app_button.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';
import 'package:humo_kids/shared/widgets/num_pad.dart';
import 'package:humo_kids/shared/widgets/pin_dots.dart';
import 'package:humo_kids/features/home/screens/main_shell_screen.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.pin});

  final String pin;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  static const int _pinLength = 4;
  final List<String> _digits = [];
  bool _hasError = false;

  void _onDigit(String d) {
    if (_digits.length >= _pinLength) return;
    setState(() {
      _digits.add(d);
      _hasError = false;
    });

    if (_digits.length == _pinLength) {
      Future.delayed(const Duration(milliseconds: 180), () {
        if (mounted) _onSave();
      });
    }
  }

  void _onBackspace() {
    if (_digits.isEmpty) return;
    setState(() {
      _digits.removeLast();
      _hasError = false;
    });
  }

  void _onReset() {
    Navigator.pop(context);
  }

  void _onSave() {
    if (_digits.length < _pinLength) return;
    final entered = _digits.join();
    if (entered == widget.pin) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.plantBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.successGreen,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Muvaffaqiyatli!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "PIN-kod saqlandi. Humo Kids ilovasiga xush kelibsiz!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grayText,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainShellScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Bosh sahifaga o'tish",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      setState(() {
        _hasError = true;
        _digits.clear();
      });
    }
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
                            "PIN-kodni tasdiqlang",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Avval kiritgan 4 xonali maxfiy kodingizni yana bir\nmarta kiriting.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grayText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 18),
                          // 4 Dots
                          PinDots(
                            length: _pinLength,
                            filled: _digits.length,
                            hasError: _hasError,
                          ),
                          if (_hasError) ...[
                            const SizedBox(height: 8),
                            const Text(
                              "PIN-kod mos kelmadi. Qaytadan kiriting.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                // Docked bottom keypad and button
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
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _onReset,
                        child: const Text(
                          "Kodni qayta yaratish",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppButton(
                        label: 'Saqlash va davom etish',
                        enabled: _digits.length == _pinLength,
                        onPressed: _onSave,
                      ),
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
