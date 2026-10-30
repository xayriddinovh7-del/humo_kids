import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/onboarding/screens/welcome_screen.dart';
import 'package:humo_kids/features/security/screens/create_pin_screen.dart';
import 'package:humo_kids/features/security/screens/pin_login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _faceIdEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Text(
                    "Mening profilim",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),

                // ── User Card ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFEDF2F7)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: const Color(0xFFEFF6FF),
                          child: Text(
                            'DA',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Dilnoza Abdullayeva",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkText,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "+998 90 123 45 67",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.grayText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Ma'lumotlarni tahrirlash tez kunda..."),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text(
                            "Ma'lumotlarni tahrirlash →",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Farzandlarim ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Farzandlarim",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _ChildTile(
                        initial: 'A',
                        bgColor: const Color(0xFFE5EFFF),
                        textColor: AppColors.primary,
                        name: 'Amirbek',
                        info: '5 yosh · 1-guruh · Quyoshchalar',
                      ),
                      const SizedBox(height: 8),
                      _ChildTile(
                        initial: 'Y',
                        bgColor: const Color(0xFFF3E8FF),
                        textColor: const Color(0xFF7C3AED),
                        name: 'Yasmina',
                        info: '3 yosh · 2-guruh · Yulduzchalar',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Xavfsizlik va bildirishnomalar ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Xavfsizlik va bildirishnomalar",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Bildirishnomalar toggle
                      _SettingsTile(
                        icon: Icons.notifications_none_rounded,
                        iconBg: const Color(0xFFEFF6FF),
                        iconColor: AppColors.primary,
                        title: "Bildirishnomalar",
                        subtitle: "Kunlik hisobot, xabar va to'lovlar",
                        trailing: Switch(
                          value: _notificationsEnabled,
                          onChanged: (v) =>
                              setState(() => _notificationsEnabled = v),
                          activeColor: AppColors.primary,
                        ),
                        onTap: () =>
                            setState(() => _notificationsEnabled = !_notificationsEnabled),
                      ),
                      const SizedBox(height: 8),

                      // PIN o'zgartirish
                      _SettingsTile(
                        icon: Icons.lock_outline_rounded,
                        iconBg: const Color(0xFFF1F5F9),
                        iconColor: const Color(0xFF475569),
                        title: "PIN-kodni o'zgartirish",
                        subtitle: "4 xonali maxfiy kod",
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.grayText,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CreatePinScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),

                      // Face ID toggle
                      _SettingsTile(
                        icon: Icons.face_retouching_natural,
                        iconBg: const Color(0xFFEFF6FF),
                        iconColor: AppColors.primary,
                        title: "Face ID orqali kirish",
                        subtitle: "Faqat shu qurilmada",
                        trailing: Switch(
                          value: _faceIdEnabled,
                          onChanged: (v) =>
                              setState(() => _faceIdEnabled = v),
                          activeColor: AppColors.primary,
                        ),
                        onTap: () =>
                            setState(() => _faceIdEnabled = !_faceIdEnabled),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Ilova haqida ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ilova haqida",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Ilova tili
                      _SettingsTile(
                        icon: Icons.translate_rounded,
                        iconBg: const Color(0xFFF1F5F9),
                        iconColor: const Color(0xFF475569),
                        title: "Ilova tili",
                        subtitle: null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "O'zbekcha",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.grayText,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 8),

                      // Qo'llab-quvvatlash
                      _SettingsTile(
                        icon: Icons.headset_mic_outlined,
                        iconBg: const Color(0xFFEFF6FF),
                        iconColor: AppColors.primary,
                        title: "Qo'llab-quvvatlash",
                        subtitle: null,
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.grayText,
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Qo'llab-quvvatlash chat tez kunda ishga tushadi!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),

                      // Maxfiylik siyosati
                      _SettingsTile(
                        icon: Icons.shield_outlined,
                        iconBg: const Color(0xFFF1F5F9),
                        iconColor: const Color(0xFF475569),
                        title: "Maxfiylik siyosati",
                        subtitle: null,
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.grayText,
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Maxfiylik siyosati sahifasi ochilmoqda..."),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Hisobdan chiqish ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.all(24),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFEE2E2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.logout_rounded,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                const Text(
                                  "Hisobdan chiqish",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.darkText,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Rostdan ham hisobdan chiqmoqchimisiz?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: const Text(
                                          "Bekor qilish",
                                          style: TextStyle(
                                            color: AppColors.grayText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const WelcomeScreen(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: const Text(
                                          "Chiqish",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                      label: const Text(
                        "Hisobdan chiqish",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFECDD3)),
                        backgroundColor: const Color(0xFFFFF1F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Version footer ──
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      "Humo Kids · 1.0.0 · Mehr bilan yaratilgan",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.grayText.withOpacity(0.6),
                      ),
                    ),
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

class _ChildTile extends StatelessWidget {
  const _ChildTile({
    required this.initial,
    required this.bgColor,
    required this.textColor,
    required this.name,
    required this.info,
  });

  final String initial;
  final Color bgColor;
  final Color textColor;
  final String name;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDF2F7)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: bgColor,
            child: Text(
              initial,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  info,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grayText,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.grayText,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEDF2F7)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkText,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grayText,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

