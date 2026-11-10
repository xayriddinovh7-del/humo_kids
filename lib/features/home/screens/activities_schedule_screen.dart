import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';

class ActivitiesScheduleScreen extends StatelessWidget {
  const ActivitiesScheduleScreen({
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
              "Mashg'ulotlar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "O'yin orqali birga o'rganamiz",
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
                  // Top Pills (Child & Date)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
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

                  // Participation Summary Card
                  Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Ajoyib ishtirok!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.darkText,
                              ),
                            ),
                            Text(
                              "4 / 5",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Bugungi 5 mashg'ulotdan 4 tasi yakunlandi.",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grayText,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            value: 4 / 5,
                            backgroundColor: Color(0xFFEFF4FF),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Section Title: 23-oktabr, juma & Haftalik jadval
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          "23-oktabr, juma",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showWeeklySchedule(context),
                        child: const Text(
                          "Haftalik jadval",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Activity 1: Ingliz tili
                  const _ActivityCard(
                    icon: Icons.translate_rounded,
                    iconBg: Color(0xFFF3E8FF),
                    iconColor: Color(0xFF7C3AED),
                    title: "Ingliz tili",
                    time: "09:00",
                    subtitle: "Ranglar va sevimli o'yinchoqlar",
                    statusText: "✓ Faol qatnashdi",
                    isCompleted: true,
                  ),
                  const SizedBox(height: 12),

                  // Activity 2: Matematika
                  const _ActivityCard(
                    icon: Icons.category_outlined,
                    iconBg: Color(0xFFF3E8FF),
                    iconColor: Color(0xFF7C3AED),
                    title: "Matematika",
                    time: "09:30",
                    subtitle: "10 gacha sanash va shakllar",
                    statusText: "✓ Faol qatnashdi",
                    isCompleted: true,
                  ),
                  const SizedBox(height: 12),

                  // Activity 3: Mental arifmetika
                  const _ActivityCard(
                    icon: Icons.calculate_outlined,
                    iconBg: Color(0xFFF3E8FF),
                    iconColor: Color(0xFF7C3AED),
                    title: "Mental arifmetika",
                    time: "10:00",
                    subtitle: "Hisob cho'plari bilan o'yin",
                    statusText: "✓ Faol qatnashdi",
                    isCompleted: true,
                  ),
                  const SizedBox(height: 12),

                  // Activity 4: Rus tili
                  const _ActivityCard(
                    icon: Icons.menu_book_outlined,
                    iconBg: Color(0xFFF3E8FF),
                    iconColor: Color(0xFF7C3AED),
                    title: "Rus tili",
                    time: "10:30",
                    subtitle: "Kuz fasli va tabiat",
                    statusText: "✓ Faol qatnashdi",
                    isCompleted: true,
                  ),
                  const SizedBox(height: 12),

                  // Activity 5: Taekwondo
                  const _ActivityCard(
                    icon: Icons.sports_martial_arts_outlined,
                    iconBg: Color(0xFFEFF6FF),
                    iconColor: AppColors.primary,
                    title: "Taekwondo",
                    time: "16:00",
                    subtitle: "Muvozanat va yengil badantarbiya",
                    statusText: "Rejalashtirilgan · 25 daqiqa",
                    isCompleted: false,
                  ),
                  const SizedBox(height: 20),

                  // Activity Image Card with Teacher Quote
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFEDF2F7)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?w=600&auto=format&fit=crop&q=80',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: const Color(0xFFE2E8F0),
                                    child: const Icon(
                                      Icons.photo,
                                      color: AppColors.primary,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "Mohira opa: «$childName sanashni mustaqil bajardi va do'stlariga ham yordam berdi».",
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              height: 1.45,
                              fontStyle: FontStyle.italic,
                            ),
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

  void _showWeeklySchedule(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.85,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Haftalik jadval ($group)",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.grayText,
                      ),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      _DayScheduleTile(
                        day: "Dushanba",
                        title: "Musiqa va ritmika",
                        time: "09:30 - 10:15",
                        teacher: "Aziza opa",
                      ),
                      _DayScheduleTile(
                        day: "Seshanba",
                        title: "Rasm chizish va loy",
                        time: "09:30 - 10:20",
                        teacher: "Mohira opa",
                      ),
                      _DayScheduleTile(
                        day: "Chorshanba",
                        title: "Ingliz tili (Kids English)",
                        time: "10:00 - 10:45",
                        teacher: "Madina opa",
                      ),
                      _DayScheduleTile(
                        day: "Payshanba",
                        title: "Jismoniy tarbiya",
                        time: "09:30 - 10:15",
                        teacher: "Rustam aka",
                      ),
                      _DayScheduleTile(
                        day: "Juma",
                        title: "Matematika va mantiq",
                        time: "09:30 - 10:20",
                        teacher: "Mohira opa",
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

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.subtitle,
    required this.statusText,
    required this.isCompleted,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String time;
  final String subtitle;
  final String statusText;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDF2F7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkText,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grayText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isCompleted
                        ? const Color(0xFF16A34A)
                        : AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayScheduleTile extends StatelessWidget {
  const _DayScheduleTile({
    required this.day,
    required this.title,
    required this.time,
    required this.teacher,
  });

  final String day;
  final String title;
  final String time;
  final String teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDF2F7)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.lightBlueBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
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
                const SizedBox(height: 2),
                Text(
                  "$time · $teacher",
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
    );
  }
}
