import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';
import 'package:humo_kids/shared/widgets/num_pad.dart';
import 'package:humo_kids/shared/widgets/pin_dots.dart';
import 'package:humo_kids/features/home/screens/main_shell_screen.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  static const int _pinLength = 4;
  final List<String> _digits = [];

  void _onDigit(String d) {
    if (_digits.length >= _pinLength) return;
    setState(() => _digits.add(d));

    if (_digits.length == _pinLength) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainShellScreen()),
        );
      });
    }
  }

  void _onBackspace() {
    if (_digits.isEmpty) return;
    setState(() => _digits.removeLast());
  }

  void _onFaceId() {
    // Simulate Face ID authentication
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Face ID orqali muvaffaqiyatli kirildi!"),
        duration: Duration(milliseconds: 900),
      ),
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainShellScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Xavfsiz kirish',
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
                          const SizedBox(height: 14),
                          // Lock badge
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlueBg,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Xush kelibsiz, Dilnoza!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Ilovaga kirish uchun 4 xonali PIN-kodingizni\nkiriting.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grayText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // 4 Dots
                          PinDots(length: _pinLength, filled: _digits.length),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                // Docked bottom keypad and links
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 6, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NumPad(
                        onDigit: _onDigit,
                        onBackspace: _onBackspace,
                        keyHeight: 46,
                        bottomLeading: Material(
                          color: const Color(0xFFF3F6FA),
                          borderRadius: BorderRadius.circular(14),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: _onFaceId,
                            child: Container(
                              height: 46,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.face_retouching_natural,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "PIN-kodni tiklash uchun SMS yuborildi."),
                            ),
                          );
                        },
                        child: const Text(
                          "PIN-kodni unutdingizmi?",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _onFaceId,
                        child: const Text(
                          "Face ID orqali kirish",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
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

