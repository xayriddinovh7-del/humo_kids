import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({
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
              'Bugungi taomnoma',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Mazali, foydali va yoshiga mos',
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

                  // Allergy info card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9EB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          color: Color(0xFFD97706),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "$childName da qayd etilgan allergiya yo'q. Ma'lumot o'zgarsa, tarbiyachiga yozing.",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF92400E),
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Meal 1: Nonushta
                  _MealCard(
                    title: 'Nonushta',
                    time: '08:30',
                    menu: 'Olmali suli bo\'tqasi, non va choy',
                    portion: 'Bo\'tqa 180 g · Non 25 g · Choy 150 ml',
                    statusBadge: 'Yaxshi yedi',
                    percentage: 90,
                    imageUrl:
                        'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=600&auto=format&fit=crop&q=80',
                    isPlanned: false,
                  ),
                  const SizedBox(height: 20),

                  // Meal 2: Tushlik
                  _MealCard(
                    title: 'Tushlik',
                    time: '12:00',
                    menu: 'Sabzavotli sho\'rva, tovuqli kotlet va guruch',
                    portion: 'Sho\'rva 150 ml · Asosiy taom 180 g',
                    statusBadge: 'Hammasini yedi',
                    percentage: 100,
                    imageUrl:
                        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80',
                    isPlanned: false,
                  ),
                  const SizedBox(height: 20),

                  // Meal 3: Tamaddi
                  _MealCard(
                    title: 'Tamaddi',
                    time: '15:30',
                    menu: 'Qatiq, banan va tvorogli bulochka',
                    portion: 'Qatiq 100 ml · Banan 80 g · Bulochka 40 g',
                    statusBadge: 'Rejalashtirilgan',
                    percentage: 0,
                    imageUrl:
                        'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=600&auto=format&fit=crop&q=80',
                    isPlanned: true,
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

class _MealCard extends StatelessWidget {
  const _MealCard({
    required this.title,
    required this.time,
    required this.menu,
    required this.portion,
    required this.statusBadge,
    required this.percentage,
    required this.imageUrl,
    required this.isPlanned,
  });

  final String title;
  final String time;
  final String menu;
  final String portion;
  final String statusBadge;
  final int percentage;
  final String imageUrl;
  final bool isPlanned;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF2F7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF1F5F9),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.restaurant_rounded,
                      color: AppColors.primary,
                      size: 48,
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (Title & Time)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkText,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Dish description
                Text(
                  menu,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                // Portion details
                Text(
                  portion,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grayText,
                  ),
                ),
                const SizedBox(height: 14),

                // Status or Progress
                if (!isPlanned) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F8EE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          statusBadge,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ),
                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF16A34A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: const Color(0xFFE2E8F0),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF16A34A),
                      ),
                      minHeight: 6,
                    ),
                  ),
                ] else ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusBadge,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFD97706),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

