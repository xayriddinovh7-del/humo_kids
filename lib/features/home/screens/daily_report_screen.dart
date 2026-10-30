import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/home/screens/food_details_screen.dart';
import 'package:humo_kids/features/home/screens/activities_schedule_screen.dart';
import 'package:humo_kids/features/home/screens/moments_gallery_screen.dart';

class DailyReportScreen extends StatelessWidget {
  const DailyReportScreen({
    super.key,
    this.childName = 'Amirbek',
    this.group = '1-guruh',
  });

  final String childName;
  final String group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.darkText),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Kunlik hisobot',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Har bir lahza e'tiborimizda",
              style: TextStyle(
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
                  // Top Pills
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$childName · $group',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const Text(
                        '23.10.2026',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.grayText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Date navigator card
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.chevron_left,
                            color: AppColors.primary, size: 22),
                        const Text(
                          '23-oktabr, juma',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkText,
                          ),
                        ),
                        const Icon(Icons.calendar_today_outlined,
                            color: AppColors.primary, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Updated pill
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '14:30 da yangilandi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Timeline Items
                  _TimelineCard(
                    time: '08:15',
                    icon: Icons.wb_sunny_outlined,
                    iconBg: const Color(0xFFEFF6FF),
                    iconColor: AppColors.primary,
                    title: 'Xayrli tong, $childName!',
                    description:
                        "Bog'chaga keldi, Harorati 36,6 °C, kayfiyati quvnoq.",
                  ),
                  _TimelineCard(
                    time: '08:30',
                    icon: Icons.restaurant_outlined,
                    iconBg: const Color(0xFFFFF7ED),
                    iconColor: const Color(0xFFEA580C),
                    title: 'Nonushta',
                    description:
                        'Olmali suli bo\'tqasi · 180 g. Taomning 90% ini yedi, choy ichdi.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FoodDetailsScreen(
                            childName: childName,
                            group: group,
                          ),
                        ),
                      );
                    },
                  ),
                  _TimelineCard(
                    time: '09:30',
                    icon: Icons.extension_outlined,
                    iconBg: const Color(0xFFF5F3FF),
                    iconColor: const Color(0xFF7C3AED),
                    title: 'Matematika va ijod',
                    description:
                        '10 gacha sanashni mashq qildi. Kuzgi barglardan rasm yasadi.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ActivitiesScheduleScreen(
                            childName: childName,
                            group: group,
                          ),
                        ),
                      );
                    },
                  ),
                  _TimelineCard(
                    time: '12:00',
                    icon: Icons.soup_kitchen_outlined,
                    iconBg: const Color(0xFFFEF3C7),
                    iconColor: const Color(0xFFD97706),
                    title: 'Tushlik',
                    description:
                        'Sabzavotli sho\'rva, tovuqli kotlet va guruch. Taomning 100% ini yedi.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FoodDetailsScreen(
                            childName: childName,
                            group: group,
                          ),
                        ),
                      );
                    },
                  ),
                  _TimelineCard(
                    time: '12:45',
                    icon: Icons.nightlight_round_outlined,
                    iconBg: const Color(0xFFEFF6FF),
                    iconColor: AppColors.primary,
                    title: 'Tushlikdan keyingi uyqu',
                    description:
                        '12:45–14:15 · 1 soat 30 daqiqa. Tinch uxladi va tetik uyg\'ondi.',
                    isLast: true,
                  ),
                  const SizedBox(height: 20),

                  // Teacher Note Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF8F1),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFD1F0DC)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDCFCE7),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'MK',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Mohira Karimova',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                  Text(
                                    '1-guruh tarbiyachisi · 14:20',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.grayText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "$childName bugun do'stlariga yordam berdi, mashg'ulotlarda faol qatnashdi. Kuzgi rasmini sizga ko'rsatishga juda oshiqyapti!",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF14532D),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Photos Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bugungi suratlar',
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
                                childName: childName,
                                group: group,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          '6 ta surat →',
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

                  // 2 Photos row
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MomentsGalleryScreen(
                            childName: childName,
                            group: group,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              height: 120,
                              child: Image.network(
                                'https://images.unsplash.com/photo-1577896851231-70ef18881754?w=400&auto=format&fit=crop&q=80',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: const Color(0xFFE2E8F0),
                                  child: const Icon(Icons.photo,
                                      color: AppColors.primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              height: 120,
                              child: Image.network(
                                'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?w=400&auto=format&fit=crop&q=80',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: const Color(0xFFE2E8F0),
                                  child: const Icon(Icons.photo,
                                      color: AppColors.primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Footer notice
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '15:30 da tamaddi rejalashtirilgan. Yangi qaydlar shu yerda paydo bo\'ladi.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grayText,
                        height: 1.4,
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

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.time,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.description,
    this.isLast = false,
    this.onTap,
  });

  final String time;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String description;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time & Vertical track
          SizedBox(
            width: 48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayText,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 1.5,
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Content Box
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              description,
                              style: const TextStyle(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

