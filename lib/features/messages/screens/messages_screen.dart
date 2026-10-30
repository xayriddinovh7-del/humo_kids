import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/messages/screens/chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedFilter = 0; // 0: Barchasi, 1: O'qilmagan
  final TextEditingController _searchController = TextEditingController();

  static const _contacts = [
    _Contact(
      initials: 'MK',
      bgColor: Color(0xFFE8F8EE),
      textColor: Color(0xFF16A34A),
      name: 'Mohira Karimova',
      role: "Amirbek · 1-guruh tarbiyachisi",
      lastMessage: "Kuzgi rasmni sizga ko'rsatishga oshiqapti!",
      time: '14:25',
      unread: 2,
    ),
    _Contact(
      initials: 'HK',
      bgColor: Color(0xFFEFF6FF),
      textColor: AppColors.primary,
      name: "Bog'cha e'lonlari",
      role: "Barcha ota-onalar uchun",
      lastMessage: "Dushanba kuni kuz bayrami bo'lib o'tadi.",
      time: '11:00',
      unread: 1,
    ),
    _Contact(
      initials: 'SR',
      bgColor: Color(0xFFFFF7ED),
      textColor: Color(0xFFEA580C),
      name: 'Sevara Rasulova',
      role: "Yasmina · 2-guruh tarbiyachisi",
      lastMessage: "Yasmina bugun tinch uxlab oldi.",
      time: '14:20',
      unread: 0,
    ),
    _Contact(
      initials: 'NA',
      bgColor: Color(0xFFF3E8FF),
      textColor: Color(0xFF7C3AED),
      name: 'Nargiza Ahmedova',
      role: "Bog'cha administratori",
      lastMessage: "Oktabr uchun hisob ilovada mavjud.",
      time: 'Kecha',
      unread: 0,
    ),
    _Contact(
      initials: 'Y',
      bgColor: Color(0xFFF1F5F9),
      textColor: Color(0xFF475569),
      name: "Qo'llab-quvvatlash",
      role: "Humo Kids yordam xizmati",
      lastMessage: "Savolingiz bo'lsa, bizga yozishingiz mumkin.",
      time: '21-okt',
      unread: 0,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unreadContacts =
        _contacts.where((c) => c.unread > 0).toList();
    final displayList = _selectedFilter == 0 ? _contacts : unreadContacts;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const Text(
                      "Xabarlar",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkText,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Bog'changiz bilan doimo aloqada",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: "Xabar yoki ism bo'yicha qidirish",
                          hintStyle: TextStyle(
                            color: AppColors.grayText,
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: AppColors.grayText,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Filter Pills
                    Row(
                      children: [
                        _FilterPill(
                          label: 'Barchasi',
                          isSelected: _selectedFilter == 0,
                          badge: null,
                          onTap: () => setState(() => _selectedFilter = 0),
                        ),
                        const SizedBox(width: 8),
                        _FilterPill(
                          label: "O'qilmagan",
                          isSelected: _selectedFilter == 1,
                          badge: unreadContacts.length,
                          onTap: () => setState(() => _selectedFilter = 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),

              // Chat List
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: displayList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == displayList.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 20),
                        child: Center(
                          child: Text(
                            "Shaxsiy suhbatlarni faqat siz va suhbatdoshingiz ko'radi.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.grayText.withOpacity(0.7),
                            ),
                          ),
                        ),
                      );
                    }
                    final contact = displayList[index];
                    return _ChatListItem(
                      contact: contact,
                      onTap: () {
                        if (contact.initials == 'MK') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChatScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "${contact.name} bilan suhbat ochilmoqda..."),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Contact {
  const _Contact({
    required this.initials,
    required this.bgColor,
    required this.textColor,
    required this.name,
    required this.role,
    required this.lastMessage,
    required this.time,
    required this.unread,
  });

  final String initials;
  final Color bgColor;
  final Color textColor;
  final String name;
  final String role;
  final String lastMessage;
  final String time;
  final int unread;
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
            if (badge != null && badge! > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : const Color(0xFFD97706),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badge',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? Colors.white : Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  const _ChatListItem({
    required this.contact,
    required this.onTap,
  });

  final _Contact contact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasUnread = contact.unread > 0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hasUnread
                ? const Color(0xFF2D63E2).withOpacity(0.18)
                : const Color(0xFFEDF2F7),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: contact.bgColor,
                  child: Text(
                    contact.initials,
                    style: TextStyle(
                      color: contact.textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: contact.initials.length > 1 ? 13 : 17,
                    ),
                  ),
                ),
                if (contact.unread > 0)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '${contact.unread}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contact.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              hasUnread ? FontWeight.w800 : FontWeight.w700,
                          color: AppColors.darkText,
                        ),
                      ),
                      Text(
                        contact.time,
                        style: TextStyle(
                          fontSize: 11,
                          color: hasUnread
                              ? AppColors.primary
                              : AppColors.grayText,
                          fontWeight:
                              hasUnread ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    contact.role,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    contact.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: hasUnread
                          ? AppColors.darkText
                          : AppColors.grayText,
                      fontWeight:
                          hasUnread ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

