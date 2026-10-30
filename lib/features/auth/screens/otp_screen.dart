import 'dart:async';
import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/shared/widgets/app_button.dart';
import 'package:humo_kids/shared/widgets/num_pad.dart';
import 'package:humo_kids/features/security/screens/create_pin_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});

  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const int _otpLength = 4;
  static const int _timerSeconds = 45;

  final List<String> _digits = [];
  int _secondsLeft = _timerSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _timerSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _onDigit(String d) {
    if (_digits.length >= _otpLength) return;
    setState(() => _digits.add(d));

    if (_digits.length == _otpLength) {
      Future.delayed(const Duration(milliseconds: 180), () {
        if (mounted) _onVerify();
      });
    }
  }

  void _onBackspace() {
    if (_digits.isEmpty) return;
    setState(() => _digits.removeLast());
  }

  void _onVerify() {
    if (_digits.length < _otpLength) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreatePinScreen()),
    );
  }

  String get _maskedPhone {
    final raw = widget.phone.replaceAll(RegExp(r'\D'), '');
    if (raw.length >= 9) {
      final last2 = raw.substring(raw.length - 2);
      return '+998 90 ••• •• $last2';
    }
    return widget.phone.isNotEmpty ? widget.phone : '+998 90 ••• •• 67';
  }

  String get _timerLabel {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Raqamni tasdiqlash',
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
                // Scrollable content area (prevents ANY overflow)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          // SMS lock badge
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlueBg,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.mark_chat_unread_outlined,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            "SMS-kodni kiriting",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "$_maskedPhone raqamiga yuborilgan 4 xonali\nkodni kiriting.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.grayText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 18),
                          // OTP 4 boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_otpLength, (index) {
                              final isFilled = index < _digits.length;
                              final isActive = index == _digits.length;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: isFilled
                                        ? AppColors.lightBlueBg
                                        : const Color(0xFFF3F6FA),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: (isFilled || isActive)
                                          ? AppColors.primary
                                          : Colors.transparent,
                                      width: (isFilled || isActive) ? 2 : 1,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    isFilled ? _digits[index] : '',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 14),
                          // Resend timer
                          if (_secondsLeft > 0)
                            Text(
                              "Kodni qayta yuborish · $_timerLabel",
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: _startTimer,
                              child: const Text(
                                "Kodni qayta yuborish",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          const SizedBox(height: 6),
                          // Change phone link
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "Telefon raqamini o'zgartirish",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                // Docked bottom button and keypad
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 6, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        label: 'Tasdiqlash',
                        enabled: _digits.length == _otpLength,
                        onPressed: _onVerify,
                      ),
                      const SizedBox(height: 12),
                      NumPad(
                        onDigit: _onDigit,
                        onBackspace: _onBackspace,
                        keyHeight: 46,
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
