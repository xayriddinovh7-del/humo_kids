import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/home/screens/main_shell_screen.dart';
import 'package:humo_kids/shared/widgets/humo_logo.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({
    super.key,
    this.amount = "500 000 so'm",
    this.date = "15.09.2026",
    this.group = "1 - Guruh",
    this.paymentMethod = "Naqd",
    this.childName = "Amirbek",
    this.period = "Sentabr 2026",
    this.statusText = "To'langan · Arxiv",
    this.noticeText =
        "Bu kvitansiya sentabr oyiga tegishli. Oktabr uchun yangi hisob alohida ko'rsatiladi.",
  });

  final String amount;
  final String date;
  final String group;
  final String paymentMethod;
  final String childName;
  final String period;
  final String statusText;
  final String noticeText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              children: [
                // Top Header / AppBar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            size: 26,
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "Kvitansiya",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),

                        // Green Check Icon Badge
                        Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDCFCE7),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check_rounded,
                              size: 38,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        const Text(
                          "To'lov qabul qilingan",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.darkText,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle
                        const Text(
                          "Tarixiy naqd to'lov kvitansiyasi",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grayText,
                          ),
                        ),
                        const SizedBox(height: 22),

                        // White Receipt Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
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
                              // Humo Kids Brand
                              Row(
                                children: const [
                                  HumoLogo(iconSize: 22, fontSize: 17),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(
                                color: Color(0xFFF1F5F9),
                                height: 1,
                                thickness: 1,
                              ),
                              const SizedBox(height: 16),

                              // Table Rows
                              _ReceiptRow(
                                label: "Summa",
                                value: amount,
                                isHighlight: true,
                              ),
                              const SizedBox(height: 14),
                              _ReceiptRow(
                                label: "Sana",
                                value: date,
                              ),
                              const SizedBox(height: 14),
                              _ReceiptRow(
                                label: "Guruh",
                                value: group,
                              ),
                              const SizedBox(height: 14),
                              _ReceiptRow(
                                label: "To'lov usuli",
                                value: paymentMethod,
                              ),
                              const SizedBox(height: 14),
                              _ReceiptRow(
                                label: "Farzand",
                                value: childName,
                              ),
                              const SizedBox(height: 14),
                              _ReceiptRow(
                                label: "Hisob davri",
                                value: period,
                              ),
                              const SizedBox(height: 18),

                              // Status Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F8EE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  statusText,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF16A34A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Notice text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            noticeText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.grayText,
                              height: 1.45,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Bottom Fixed Action Buttons
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Action Button 1: Download
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Kvitansiya PDF formatida muvaffaqiyatli yuklab olindi!"),
                                backgroundColor: Color(0xFF16A34A),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.file_download_outlined,
                              color: Colors.white, size: 20),
                          label: const Text(
                            "Kvitansiyani yuklab olish",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Action Button 2: Back to Home
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainShellScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.home_outlined,
                              color: AppColors.primary, size: 20),
                          label: const Text(
                            "Bosh sahifaga qaytish",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEFF6FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
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
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({
    required this.label,
    required this.value,
    this.isHighlight = false,
  });

  final String label;
  final String value;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.grayText,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 15 : 13,
            fontWeight: isHighlight ? FontWeight.w800 : FontWeight.w700,
            color: isHighlight ? const Color(0xFF16A34A) : AppColors.darkText,
          ),
        ),
      ],
    );
  }
}

