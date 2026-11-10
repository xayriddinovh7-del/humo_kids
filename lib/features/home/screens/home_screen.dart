import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';
import 'package:humo_kids/features/home/screens/daily_report_screen.dart';
import 'package:humo_kids/features/home/screens/food_details_screen.dart';
import 'package:humo_kids/features/home/screens/moments_gallery_screen.dart';
import 'package:humo_kids/features/notifications/screens/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onNavigateToPayments});

  final VoidCallback? onNavigateToPayments;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedChildIndex = 0; // 0: Amirbek, 1: Yasmina

  bool get _isAmirbek => _selectedChildIndex == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top App Bar row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HumoLogo(iconSize: 22, fontSize: 18),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.darkText,
                                size: 22,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Greeting & Date
                  const Text(
                    "Assalomu alaykum, Dilnoza!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Juma, 23-oktabr 2026 · 14:30",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grayText,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Child Selector Pill Tabs
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF2F7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _ChildTab(
                            name: 'Amirbek',
                            isSelected: _isAmirbek,
                            onTap: () {
                              if (!_isAmirbek) {
                                HapticFeedback.selectionClick();
                                setState(() => _selectedChildIndex = 0);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: _ChildTab(
                            name: 'Yasmina',
                            isSelected: !_isAmirbek,
                            onTap: () {
                              if (_isAmirbek) {
                                HapticFeedback.selectionClick();
                                setState(() => _selectedChildIndex = 1);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Child Profile Card
                  _ChildProfileCard(
                    avatarLetter: _isAmirbek ? 'A' : 'Y',
                    avatarColor: _isAmirbek
                        ? AppColors.primary
                        : const Color(0xFF7C3AED),
                    avatarBg: _isAmirbek
                        ? const Color(0xFFE5EFFF)
                        : const Color(0xFFF3E8FF),
                    name: _isAmirbek ? 'Amirbek' : 'Yasmina',
                    details: _isAmirbek
                        ? "5 yosh · 1-guruh · «Quyoshchalar»"
                        : "3 yosh · 2-guruh · «Yulduzchalar»",
                    arrivedTime: _isAmirbek
                        ? "Bugun 08:15 da keldi"
                        : "Bugun 08:20 da keldi",
                  ),
                  const SizedBox(height: 16),

                  // 3 Status Cards
                  Row(
                    children: [
                      Expanded(
                        child: _StatusCard(
                          icon: Icons.thermostat_outlined,
                          iconColor: AppColors.primary,
                          bg: const Color(0xFFEFF6FF),
                          value: _isAmirbek ? '36,6 °C' : '36,5 °C',
                          label: 'Harorat',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DailyReportScreen(
                                  childName: _isAmirbek ? 'Amirbek' : 'Yasmina',
                                  group: _isAmirbek ? '1-guruh' : '2-guruh',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatusCard(
                          icon: Icons.sentiment_satisfied_alt_rounded,
                          iconColor: const Color(0xFF16A34A),
                          bg: const Color(0xFFE8F8EE),
                          value: _isAmirbek ? 'Quvnoq' : 'Xotirjam',
                          label: 'Kayfiyat',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DailyReportScreen(
                                  childName: _isAmirbek ? 'Amirbek' : 'Yasmina',
                                  group: _isAmirbek ? '1-guruh' : '2-guruh',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatusCard(
                          icon: Icons.restaurant_outlined,
                          iconColor: const Color(0xFFEA580C),
                          bg: const Color(0xFFFFF3E8),
                          value: _isAmirbek ? '90%' : '80%',
                          label: 'Nonushta',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FoodDetailsScreen(
                                  childName:
                                      _isAmirbek ? 'Amirbek' : 'Yasmina',
                                  group: _isAmirbek ? '1-guruh' : '2-guruh',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Payment Status Card
                  if (_isAmirbek)
                    _PaymentBanner(
                      icon: Icons.account_balance_wallet_outlined,
                      iconBg: const Color(0xFFDBEAFE),
                      iconColor: AppColors.primary,
                      bg: const Color(0xFFF0F5FF),
                      title: "Oktabr uchun 600 000 so'm",
                      subtitle: "28-oktabrgacha to'lang",
                      onTap: widget.onNavigateToPayments,
                    )
                  else
                    _PaymentBanner(
                      icon: Icons.check_circle_outline,
                      iconBg: const Color(0xFFDCFCE7),
                      iconColor: const Color(0xFF16A34A),
                      bg: const Color(0xFFEAF7EE),
                      title: "Oktabr to'lovi amalga oshirilgan",
                      subtitle: "600 000 so'm · 05.10.2026",
                      onTap: widget.onNavigateToPayments,
                    ),
                  const SizedBox(height: 24),

                  // Section: Bugungi kun
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bugungi kun',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DailyReportScreen(
                                childName: _isAmirbek ? 'Amirbek' : 'Yasmina',
                                group: _isAmirbek ? '1-guruh' : '2-guruh',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'To\'liq hisobot →',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Daily Timeline Card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DailyReportScreen(
                            childName: _isAmirbek ? 'Amirbek' : 'Yasmina',
                            group: _isAmirbek ? '1-guruh' : '2-guruh',
                          ),
                        ),
                      );
                    },
                    child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFEDF2F7)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Lunch
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F8EE),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.restaurant_outlined,
                                color: Color(0xFF16A34A),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _isAmirbek
                                        ? "Tushlikni yaxshi yedi"
                                        : "Tushlikdan 80% yedi",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _isAmirbek
                                        ? "12:00 · Sho'rva va tovuqli kotlet · 100%"
                                        : "12:00 · Sabzavotli sho'rva va guruch",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grayText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(
                              height: 1, color: Color(0xFFF1F5F9)),
                        ),
                        // Row 2: Sleep
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.nightlight_round_outlined,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _isAmirbek
                                        ? "Tiniqib uxlab oldi"
                                        : "Shirin uyqudan uyg'ondi",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _isAmirbek
                                        ? "12:45–14:15 · 1 soat 30 daqiqa"
                                        : "12:30–14:15 · 1 soat 45 daqiqa",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grayText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Keyingi: 15:30 · Tamaddi",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grayText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  const SizedBox(height: 24),

                  // Section: Kichik lahzalar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kichik lahzalar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MomentsGalleryScreen(
                                childName: _isAmirbek ? 'Amirbek' : 'Yasmina',
                                group: _isAmirbek ? '1-guruh' : '2-guruh',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Barchasi →',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Moments photo
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MomentsGalleryScreen(
                            childName: _isAmirbek ? 'Amirbek' : 'Yasmina',
                            group: _isAmirbek ? '1-guruh' : '2-guruh',
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Image.network(
                          _isAmirbek
                              ? 'https://images.unsplash.com/photo-1577896851231-70ef18881754?w=600&auto=format&fit=crop&q=80'
                              : 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?w=600&auto=format&fit=crop&q=80',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: const Color(0xFFE2E8F0),
                            child: const Icon(Icons.photo_library_outlined,
                                color: AppColors.primary, size: 40),
                          ),
                        ),
                      ),
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

class _ChildTab extends StatelessWidget {
  const _ChildTab({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.grayText,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              const Icon(Icons.check, color: Colors.white, size: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChildProfileCard extends StatelessWidget {
  const _ChildProfileCard({
    required this.avatarLetter,
    required this.avatarColor,
    required this.avatarBg,
    required this.name,
    required this.details,
    required this.arrivedTime,
  });

  final String avatarLetter;
  final Color avatarColor;
  final Color avatarBg;
  final String name;
  final String details;
  final String arrivedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF2F7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: avatarBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  avatarLetter,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: avatarColor,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      details,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grayText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F8EE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Bog'chada",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF16A34A),
                  ),
                ),
              ),
              Text(
                arrivedTime,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.iconColor,
    required this.bg,
    required this.value,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color bg;
  final String value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.grayText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentBanner extends StatelessWidget {
  const _PaymentBanner({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.bg,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color bg;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
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
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.grayText,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: AppColors.grayText, size: 20),
          ],
        ),
      ),
    );
  }
}

