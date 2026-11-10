import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humo_kids/core/api/token_storage.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/home/screens/activities_schedule_screen.dart';
import 'package:humo_kids/features/home/screens/daily_report_screen.dart';
import 'package:humo_kids/features/home/screens/food_details_screen.dart';
import 'package:humo_kids/features/messages/screens/chat_screen.dart';
import 'package:humo_kids/features/notifications/screens/notifications_screen.dart';
import 'package:humo_kids/features/onboarding/screens/welcome_screen.dart';
import 'package:humo_kids/features/security/screens/create_pin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Dilnoza Abdullayeva";
  String _userPhone = "+998 90 123 45 67";
  String _selectedLanguage = "O'zbekcha";

  bool _notificationsEnabled = true;
  bool _faceIdEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final name = await TokenStorage.getUserName();
    final phone = await TokenStorage.getUserPhone();
    if (mounted) {
      setState(() {
        if (name != null && name.isNotEmpty) _userName = name;
        if (phone != null && phone.isNotEmpty) _userPhone = phone;
      });
    }
  }

  void _editProfile() {
    final nameController = TextEditingController(text: _userName);
    final phoneController = TextEditingController(text: _userPhone);

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              24,
              20,
              24,
              MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Text(
                  "Ma'lumotlarni tahrirlash",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkText,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: AppColors.grayText),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "F.I.SH.",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              "Telefon raqam",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (nameController.text.trim().isNotEmpty) {
                    final newName = nameController.text.trim();
                    final newPhone = phoneController.text.trim();
                    await TokenStorage.saveUserData(
                      name: newName,
                      phone: newPhone,
                    );
                    if (ctx.mounted) {
                      Navigator.pop(ctx);
                    }
                    if (mounted) {
                      setState(() {
                        _userName = newName;
                        _userPhone = newPhone;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Profil ma'lumotlari yangilandi!"),
                          backgroundColor: Color(0xFF16A34A),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Saqlash",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

  void _showChildDetails({
    required String name,
    required String group,
    required String age,
    required String teacher,
    required String attendance,
    required Color color,
    required String initial,
  }) {
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: color.withValues(alpha: 0.15),
                  child: Text(
                    initial,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: color,
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
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "$age · $group",
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.grayText,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: AppColors.grayText),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEDF2F7)),
              ),
              child: Column(
                children: [
                  _infoRow("Tarbiyachi:", teacher),
                  const Divider(height: 16),
                  _infoRow("Oylik davomat:", attendance),
                  const Divider(height: 16),
                  _infoRow("Salomatlik holati:", "Allergiya qayd etilmagan"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Tezkor amallar",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            _actionButton(
              icon: Icons.assignment_outlined,
              label: "Kunlik hisobotni ko'rish",
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DailyReportScreen(
                      childName: name,
                      group: group,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _actionButton(
              icon: Icons.event_note_outlined,
              label: "Mashg'ulotlar jadvali",
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ActivitiesScheduleScreen(
                      childName: name,
                      group: group,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _actionButton(
              icon: Icons.restaurant_menu_outlined,
              label: "Bugungi taomnoma",
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FoodDetailsScreen(
                      childName: name,
                      group: group,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  ),
);
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: AppColors.grayText)),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText)),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  void _chooseLanguage() {
    final languages = [
      "O'zbekcha",
      "Ўзбекча (Кирилл)",
      "Русский",
      "English",
    ];

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Text(
                  "Ilova tilini tanlang",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 14),
                ...languages.map(
                  (lang) {
                    final isSelected = _selectedLanguage == lang;
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      tileColor:
                          isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                      title: Text(
                        lang,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                          color:
                              isSelected ? AppColors.primary : AppColors.darkText,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_rounded,
                              color: AppColors.primary)
                          : null,
                      onTap: () {
                        setState(() => _selectedLanguage = lang);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Ilova tili o'zgartirildi: $lang"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSupport() {
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.headset_mic_outlined,
                        color: AppColors.primary, size: 24),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Qo'llab-quvvatlash xizmati",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Center(
                  child: Text(
                    "Savollaringiz bormi? Biz sizga yordam berishdan mamnunmiz.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: AppColors.grayText),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.phone_rounded,
                      color: Color(0xFF16A34A)),
                  title: const Text("Bog'cha ma'muriyati",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text("+998 71 200 42 42 (08:00 - 18:00)",
                      style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  tileColor: const Color(0xFFF8FAFC),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("+998 71 200 42 42 raqamiga qo'ng'iroq qilinmoqda..."),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.chat_bubble_outline_rounded,
                      color: AppColors.primary),
                  title: const Text("Tarbiyachi bilan bog'lanish",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text("Xabarlar bo'limi orqali yozish",
                      style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  tileColor: const Color(0xFFF8FAFC),
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPrivacyPolicy() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Text(
                    "Maxfiylik siyosati",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.grayText),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    Text(
                      "Humo Kids ilovasi orqali bolalaringizning shaxsiy ma'lumotlari, salomatligi va oilaviy xavfsizligini ta'minlash bizning ustuvor vazifamizdir.",
                      style: TextStyle(
                          fontSize: 13, height: 1.5, color: Color(0xFF334155)),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "1. Ma'lumotlarni yig'ish va saqlash",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Ilovada faqat bog'cha bilan o'zaro hamkorlik, ta'lim-tarbiya jarayoni va to'lovlarni boshqarish uchun zarur bo'lgan ma'lumotlar qayta ishlanadi. Barcha shaxsiy ma'lumotlar shifrlangan holatda saqlanadi.",
                      style: TextStyle(
                          fontSize: 13, height: 1.5, color: Color(0xFF334155)),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "2. Foto va video yozuvlar",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Farzandingizning mashg'ulotlar jarayonidagi fotosuratlari faqatgina uning qonuniy vakillariga (ota-onalariga) ko'rinadi va begonalarga uzatilmaydi.",
                      style: TextStyle(
                          fontSize: 13, height: 1.5, color: Color(0xFF334155)),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "3. To'lov xavfsizligi",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Bank kartalari ma'lumotlari xalqaro PCI DSS xavfsizlik standartlariga muvofiq qayta ishlanadi. CVV kodlari tizimda saqlanmaydi.",
                      style: TextStyle(
                          fontSize: 13, height: 1.5, color: Color(0xFF334155)),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text("Tushunarli",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: const Color(0xFFEFF6FF),
                          child: Text(
                            _userName
                                .split(' ')
                                .take(2)
                                .map((e) => e.isNotEmpty ? e[0] : '')
                                .join(),
                            style: const TextStyle(
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
                            children: [
                              Text(
                                _userName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkText,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                _userPhone,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.grayText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _editProfile,
                          child: const Text(
                            "Tahrirlash →",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
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
                        info: '5 yosh · 1-guruh · «Quyoshchalar»',
                        onTap: () => _showChildDetails(
                          name: 'Amirbek',
                          group: '1-guruh «Quyoshchalar»',
                          age: '5 yosh',
                          teacher: 'Mohira Karimova',
                          attendance: '96% (22/23 kun)',
                          color: AppColors.primary,
                          initial: 'A',
                        ),
                      ),
                      const SizedBox(height: 8),
                      _ChildTile(
                        initial: 'Y',
                        bgColor: const Color(0xFFF3E8FF),
                        textColor: const Color(0xFF7C3AED),
                        name: 'Yasmina',
                        info: '3 yosh · 2-guruh · «Yulduzchalar»',
                        onTap: () => _showChildDetails(
                          name: 'Yasmina',
                          group: '2-guruh «Yulduzchalar»',
                          age: '3 yosh',
                          teacher: 'Sevara Rasulova',
                          attendance: '100% (23/23 kun)',
                          color: const Color(0xFF7C3AED),
                          initial: 'Y',
                        ),
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

                      // Bildirishnomalar toggle & navigation
                      _SettingsTile(
                        icon: Icons.notifications_none_rounded,
                        iconBg: const Color(0xFFEFF6FF),
                        iconColor: AppColors.primary,
                        title: "Bildirishnomalar",
                        subtitle: "Kunlik hisobot, xabar va to'lovlar",
                        trailing: Switch.adaptive(
                          value: _notificationsEnabled,
                          activeTrackColor: AppColors.primary,
                          activeThumbColor: Colors.white,
                          onChanged: (v) {
                            HapticFeedback.lightImpact();
                            setState(() => _notificationsEnabled = v);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(v
                                    ? "Bildirishnomalar yoqildi"
                                    : "Bildirishnomalar o'chirildi"),
                                duration: const Duration(milliseconds: 900),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
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
                        trailing: Switch.adaptive(
                          value: _faceIdEnabled,
                          activeTrackColor: AppColors.primary,
                          activeThumbColor: Colors.white,
                          onChanged: (v) {
                            HapticFeedback.lightImpact();
                            setState(() => _faceIdEnabled = v);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(v
                                    ? "Face ID / Biometrik kirish faollashtirildi"
                                    : "Face ID kirish o'chirildi"),
                                duration: const Duration(milliseconds: 900),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() => _faceIdEnabled = !_faceIdEnabled);
                        },
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
                          children: [
                            Text(
                              _selectedLanguage,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.grayText,
                            ),
                          ],
                        ),
                        onTap: _chooseLanguage,
                      ),
                      const SizedBox(height: 8),

                      // Qo'llab-quvvatlash
                      _SettingsTile(
                        icon: Icons.headset_mic_outlined,
                        iconBg: const Color(0xFFEFF6FF),
                        iconColor: AppColors.primary,
                        title: "Qo'llab-quvvatlash",
                        subtitle: "Aloqa va yordam markazi",
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.grayText,
                        ),
                        onTap: _showSupport,
                      ),
                      const SizedBox(height: 8),

                      // Maxfiylik siyosati
                      _SettingsTile(
                        icon: Icons.shield_outlined,
                        iconBg: const Color(0xFFF1F5F9),
                        iconColor: const Color(0xFF475569),
                        title: "Maxfiylik siyosati",
                        subtitle: "Xavfsizlik va ma'lumotlar himoyasi",
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.grayText,
                        ),
                        onTap: _showPrivacyPolicy,
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
                                            vertical: 12,
                                          ),
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
                        color: AppColors.grayText.withValues(alpha: 0.6),
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
    required this.onTap,
  });

  final String initial;
  final Color bgColor;
  final Color textColor;
  final String name;
  final String info;
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
