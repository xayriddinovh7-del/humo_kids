import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/shared/widgets/app_button.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';
import 'package:humo_kids/features/auth/screens/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: '+998 ');

  bool get _isValid {
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 12; // 998 + 9 digits
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (!_isValid) return;
    final phone = _phoneController.text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OtpScreen(phone: phone)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Kirish',
          style: TextStyle(
            fontSize: 20,
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // Logo row
                  const Center(
                    child: HumoLogo(iconSize: 22, fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  // Title
                  const Text(
                    "Keling, tanishamiz!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Bog'chaga bergan telefon raqamingizni kiriting.\nSizga tasdiqlash kodini yuboramiz.",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grayText,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Phone label
                  const Text(
                    "Telefon raqamingiz",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Phone input
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _phoneController,
                    builder: (context, value, _) {
                      return TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          if (_isValid) _onContinue();
                        },
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkText,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[\d\s\+]')),
                          LengthLimitingTextInputFormatter(17),
                        ],
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: '+998 90 123 45 67',
                          hintStyle: const TextStyle(
                            color: AppColors.grayText,
                            fontSize: 15,
                          ),
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFDCE6F5),
                              width: 1.2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFDCE6F5),
                              width: 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1.8,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Raqam faqat hisobingizga kirish uchun ishlatiladi.",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grayText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Continue button
                  AppButton(
                    label: 'Davom etish',
                    enabled: _isValid,
                    onPressed: _onContinue,
                  ),
                  const SizedBox(height: 16),
                  // Terms text
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.grayText,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: "Davom etish orqali siz "),
                          TextSpan(
                            text: "Foydalanish shartlari",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: " va "),
                          TextSpan(
                            text: "Maxfiylik siyosati",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: "ga rozilik bildirasiz."),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Info card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F5FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Raqamingiz topilmadimi?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkText,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Bog'cha administratoriga murojaat qiling. U hisobingizni faollashtiradi.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grayText,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
