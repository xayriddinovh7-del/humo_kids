import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';

class MomentsGalleryScreen extends StatefulWidget {
  const MomentsGalleryScreen({
    super.key,
    this.childName = 'Amirbek',
    this.group = '1-guruh',
  });

  final String childName;
  final String group;

  @override
  State<MomentsGalleryScreen> createState() => _MomentsGalleryScreenState();
}

class _MomentsGalleryScreenState extends State<MomentsGalleryScreen> {
  int _selectedFilter = 0; // 0: Barchasi, 1: Mashg'ulotlar, 2: Sayr

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
              'Kichik lahzalar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.darkText,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Katta xotiralarga aylanadigan kunlar',
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
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${widget.childName} · ${widget.group}',
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

                  // Filter Pills: Barchasi, Mashg'ulotlar, Sayr
                  Row(
                    children: [
                      _FilterPill(
                        label: 'Barchasi',
                        isSelected: _selectedFilter == 0,
                        selectedBg: AppColors.primary,
                        selectedColor: Colors.white,
                        unselectedBg: const Color(0xFFEDF2F7),
                        unselectedColor: AppColors.grayText,
                        onTap: () => setState(() => _selectedFilter = 0),
                      ),
                      const SizedBox(width: 8),
                      _FilterPill(
                        label: "Mashg'ulotlar",
                        isSelected: _selectedFilter == 1,
                        selectedBg: const Color(0xFF7C3AED),
                        selectedColor: Colors.white,
                        unselectedBg: const Color(0xFFF3E8FF),
                        unselectedColor: const Color(0xFF7C3AED),
                        onTap: () => setState(() => _selectedFilter = 1),
                      ),
                      const SizedBox(width: 8),
                      _FilterPill(
                        label: 'Sayr',
                        isSelected: _selectedFilter == 2,
                        selectedBg: const Color(0xFF16A34A),
                        selectedColor: Colors.white,
                        unselectedBg: const Color(0xFFE8F8EE),
                        unselectedColor: const Color(0xFF16A34A),
                        onTap: () => setState(() => _selectedFilter = 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Date header 1: Bugun · 23-oktabr
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Bugun · 23-oktabr',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      Text(
                        '6 ta surat',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Featured Photo Card
                  Container(
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
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1577896851231-70ef18881754?w=700&auto=format&fit=crop&q=80',
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
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Kuz ranglarini kashf etdik',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '1-guruh · Mohira opa · 10:45',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grayText,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.file_download_outlined,
                                    color: AppColors.primary),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Surat galereyaga saqlandi!"),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // 2-Column Photo Grid
                  Row(
                    children: [
                      Expanded(
                        child: _GridPhotoCard(
                          imageUrl:
                              'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?w=400&auto=format&fit=crop&q=80',
                          caption: 'Birga quramiz · 10:15',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _GridPhotoCard(
                          imageUrl:
                              'https://images.unsplash.com/photo-1544717305-2782549b5136?w=400&auto=format&fit=crop&q=80',
                          caption: 'Kuzgi sayr · 11:00',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Date header 2: Kecha · 22-oktabr
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Kecha · 22-oktabr',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      Text(
                        '4 ta surat',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 2-Column Photo Grid for yesterday
                  Row(
                    children: [
                      Expanded(
                        child: _GridPhotoCard(
                          imageUrl:
                              'https://images.unsplash.com/photo-1544717305-2782549b5136?w=400&auto=format&fit=crop&q=80',
                          caption: 'Kuzgi sayr · 10:40',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _GridPhotoCard(
                          imageUrl:
                              'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?w=400&auto=format&fit=crop&q=80',
                          caption: 'Konstruktor · 11:20',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Privacy Notice Card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F5FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.12)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Suratlar faqat guruh ota-onalariga ko'rinadi. Boshqa bolalar suratini ruxsatsiz ulashmang.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF334155),
                              height: 1.45,
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
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.selectedBg,
    required this.selectedColor,
    required this.unselectedBg,
    required this.unselectedColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color selectedBg;
  final Color selectedColor;
  final Color unselectedBg;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        ),
      ),
    );
  }
}

class _GridPhotoCard extends StatelessWidget {
  const _GridPhotoCard({
    required this.imageUrl,
    required this.caption,
  });

  final String imageUrl;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDF2F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Icon(Icons.photo, color: AppColors.primary),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              caption,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.grayText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

