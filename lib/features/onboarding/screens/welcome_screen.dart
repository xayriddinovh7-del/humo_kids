import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/shared/widgets/app_button.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';
import 'package:humo_kids/features/auth/screens/login_screen.dart';
import 'package:humo_kids/features/security/screens/pin_login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Title
                  const Text(
                    'Humo Kids',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F3A8A),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Hero circle area
                  SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer light blue circle
                        Container(
                          width: 220,
                          height: 220,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEEF4FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Inner white circle with Humo Logo
                        Container(
                          width: 168,
                          height: 168,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2862EC)
                                    .withValues(alpha: 0.08),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              HumoBirdIcon(
                                size: 40,
                                color: Color(0xFF0F3A8A),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'HUMO',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF0F3A8A),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Floating heart icon (left)
                        Positioned(
                          left: 16,
                          top: 44,
                          child: _FloatingIcon(
                            icon: Icons.favorite_border_rounded,
                            iconColor: AppColors.heartIcon,
                            bgColor: AppColors.heartBg,
                          ),
                        ),
                        // Floating plant icon (right)
                        Positioned(
                          right: 16,
                          bottom: 36,
                          child: _FloatingIcon(
                            icon: Icons.spa_outlined,
                            iconColor: AppColors.plantIcon,
                            bgColor: AppColors.plantBg,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Heading
                  const Text(
                    "Farzandingiz haqida\nhamma narsa — bir\nilovada!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                      height: 1.25,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Subtitle
                  const Text(
                    "Har bir kichik yutuqdan xabardor bo'ling. Bog'cha\nva oila doimo birga.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grayText,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Security badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.verified_user_outlined,
                        color: AppColors.plantIcon,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Mehr bilan yaratilgan. Xavfsiz saqlanadi.",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.grayText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // CTA Button
                  AppButton(
                    label: 'Boshlash',
                    trailing: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  // Existing account link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hisobingiz bormi? ",
                        style: TextStyle(fontSize: 13, color: AppColors.grayText),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PinLoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "PIN orqali kirish",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  const _FloatingIcon({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}
