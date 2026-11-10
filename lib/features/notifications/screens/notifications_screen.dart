import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humo_kids/core/constants/app_colors.dart';
import 'package:humo_kids/features/home/screens/daily_report_screen.dart';
import 'package:humo_kids/features/messages/screens/chat_screen.dart';
import 'package:humo_kids/features/payments/screens/my_cards_screen.dart';

enum NotificationType { task, payment, report, health, event }

class NotificationItemModel {
  NotificationItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.time,
    required this.type,
    this.isUnread = true,
    this.isTaskDone = false,
    this.actionLabel,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String time;
  final NotificationType type;
  bool isUnread;
  bool isTaskDone;
  final String? actionLabel;
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedFilter = 0; // 0: Barchasi, 1: Vazifalar, 2: To'lovlar, 3: E'lonlar

  final List<NotificationItemModel> _notifications = [
    NotificationItemModel(
      id: '1',
      title: "Kuzgi ko'rgazma uchun topshiriq",
      subtitle: "Mohira opa · 1-guruh",
      description:
          "Ertangi amaliy mashg'ulot uchun bolangiz bilan birga 5-6 dona sariq xazon barglari va bir nechta quruq novdalar olib kelishingizni so'raymiz.",
      time: "Bugun, 14:30",
      type: NotificationType.task,
      isUnread: true,
      actionLabel: "Tarbiyachiga yozish",
    ),
    NotificationItemModel(
      id: '2',
      title: "Oktabr oyi bog'cha to'lovi",
      subtitle: "Muddati: 28-oktabrgacha · 600 000 so'm",
      description:
          "Amirbek uchun 2026-yil oktabr oyi to'lovini o'z vaqtida amalga oshirishingizni so'raymiz. To'lovni ilova orqali komissiyasiz to'lashingiz mumkin.",
      time: "Bugun, 10:00",
      type: NotificationType.payment,
      isUnread: true,
      actionLabel: "Hozir to'lash",
    ),
    NotificationItemModel(
      id: '3',
      title: "Bugungi kunlik hisobot tayyor",
      subtitle: "Tushlik: 100% · Uyqu: 1s 30d",
      description:
          "Amirbekning bugungi nonushta, tushlik, mashg'ulotlar va kayfiyati haqidagi to'liq ma'lumotlar yangilandi.",
      time: "Bugun, 15:45",
      type: NotificationType.report,
      isUnread: true,
      actionLabel: "Hisobotni ko'rish",
    ),
    NotificationItemModel(
      id: '4',
      title: "Rejaviy tibbiy ko'rik",
      subtitle: "Hamshira Shahnoza opa",
      description:
          "Dushanba kuni bolalar uchun rejaviy stomatolog va pediatr ko'rigi bo'lib o'tadi. Salomatlik ko'rsatkichlari tekshiriladi.",
      time: "Kecha, 16:20",
      type: NotificationType.health,
      isUnread: false,
    ),
    NotificationItemModel(
      id: '5',
      title: "Kuz bayrami tadbiri",
      subtitle: "Barcha guruhlar uchun",
      description:
          "30-oktabr soat 10:00 da bog'chamiz hovlisida «Oltin kuz» bayram dasturi bo'lib o'tadi. Ota-onalar taklif etiladi.",
      time: "22-oktabr",
      type: NotificationType.event,
      isUnread: false,
    ),
  ];

  int get _unreadCount => _notifications.where((n) => n.isUnread).length;

  void _markAllAsRead() {
    setState(() {
      for (final n in _notifications) {
        n.isUnread = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Barcha bildirishnomalar o'qilgan deb belgilandi"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onNotificationTap(NotificationItemModel item) {
    setState(() {
      item.isUnread = false;
    });

    switch (item.type) {
      case NotificationType.task:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ChatScreen(),
          ),
        );
        break;
      case NotificationType.payment:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MyCardsScreen(),
          ),
        );
        break;
      case NotificationType.report:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const DailyReportScreen(),
          ),
        );
        break;
      case NotificationType.health:
      case NotificationType.event:
        _showDetailBottomSheet(item);
        break;
    }
  }

  void _showDetailBottomSheet(NotificationItemModel item) {
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
                _buildTypeIcon(item.type, size: 44),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${item.subtitle} · ${item.time}",
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
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEDF2F7)),
              ),
              child: Text(
                item.description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.darkText,
                ),
              ),
            ),
            const SizedBox(height: 24),
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
                  elevation: 0,
                ),
                child: const Text(
                  "Tushunarli",
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

  List<NotificationItemModel> _getFilteredList() {
    switch (_selectedFilter) {
      case 1:
        return _notifications
            .where((n) => n.type == NotificationType.task)
            .toList();
      case 2:
        return _notifications
            .where((n) => n.type == NotificationType.payment)
            .toList();
      case 3:
        return _notifications
            .where((n) =>
                n.type == NotificationType.event ||
                n.type == NotificationType.health)
            .toList();
      default:
        return _notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _getFilteredList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Custom AppBar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
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
                                  border:
                                      Border.all(color: const Color(0xFFE2E8F0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.02),
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
                            const Flexible(
                              child: Text(
                                "Bildirishnomalar",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkText,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (_unreadCount > 0)
                        GestureDetector(
                          onTap: _markAllAsRead,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Hammasi o'qildi",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Unread status banner if unread > 0
                if (_unreadCount > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Sizda $_unreadCount ta yangi bildirishnoma mavjud",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 8),

                // Filter pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _FilterTabPill(
                        label: "Barchasi",
                        isSelected: _selectedFilter == 0,
                        onTap: () => setState(() => _selectedFilter = 0),
                      ),
                      const SizedBox(width: 8),
                      _FilterTabPill(
                        label: "Vazifalar (To-do)",
                        isSelected: _selectedFilter == 1,
                        onTap: () => setState(() => _selectedFilter = 1),
                      ),
                      const SizedBox(width: 8),
                      _FilterTabPill(
                        label: "To'lovlar",
                        isSelected: _selectedFilter == 2,
                        onTap: () => setState(() => _selectedFilter = 2),
                      ),
                      const SizedBox(width: 8),
                      _FilterTabPill(
                        label: "E'lonlar",
                        isSelected: _selectedFilter == 3,
                        onTap: () => setState(() => _selectedFilter = 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Notifications List
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.notifications_off_outlined,
                                size: 48,
                                color: AppColors.grayText,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Hozircha hech narsa yo'q",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkText,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Yangi bildirishnomalar shu yerda ko'rinadi",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grayText,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            return _NotificationCard(
                              item: item,
                              onTap: () => _onNotificationTap(item),
                              onToggleTask: () {
                                setState(() {
                                  item.isTaskDone = !item.isTaskDone;
                                });
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildTypeIcon(NotificationType type, {double size = 40}) {
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (type) {
      case NotificationType.task:
        icon = Icons.edit_calendar_rounded;
        iconColor = const Color(0xFFD97706);
        bgColor = const Color(0xFFFFFBEB);
        break;
      case NotificationType.payment:
        icon = Icons.account_balance_wallet_rounded;
        iconColor = AppColors.primary;
        bgColor = const Color(0xFFEFF6FF);
        break;
      case NotificationType.report:
        icon = Icons.assignment_rounded;
        iconColor = const Color(0xFF16A34A);
        bgColor = const Color(0xFFE8F8EE);
        break;
      case NotificationType.health:
        icon = Icons.health_and_safety_rounded;
        iconColor = const Color(0xFF7C3AED);
        bgColor = const Color(0xFFF3E8FF);
        break;
      case NotificationType.event:
        icon = Icons.celebration_rounded;
        iconColor = const Color(0xFFEA580C);
        bgColor = const Color(0xFFFFF7ED);
        break;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: iconColor, size: size * 0.52),
    );
  }
}

class _FilterTabPill extends StatelessWidget {
  const _FilterTabPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          HapticFeedback.selectionClick();
        }
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : AppColors.darkText,
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.item,
    required this.onTap,
    required this.onToggleTask,
  });

  final NotificationItemModel item;
  final VoidCallback onTap;
  final VoidCallback onToggleTask;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: item.isUnread
                ? AppColors.primary.withValues(alpha: 0.25)
                : const Color(0xFFEDF2F7),
            width: item.isUnread ? 1.4 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NotificationsScreenState._buildTypeIcon(item.type),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: item.isUnread
                                    ? FontWeight.w800
                                    : FontWeight.w700,
                                color: AppColors.darkText,
                                decoration: item.isTaskDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                          if (item.isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(left: 6),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${item.subtitle} · ${item.time}",
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.grayText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 12.5,
                color: item.isTaskDone
                    ? AppColors.grayText
                    : const Color(0xFF334155),
                height: 1.4,
              ),
            ),
            if (item.type == NotificationType.task) ...[
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  GestureDetector(
                    onTap: onToggleTask,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.isTaskDone
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: item.isTaskDone
                              ? const Color(0xFF16A34A)
                              : AppColors.grayText,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.isTaskDone
                              ? "Vazifa bajarildi"
                              : "Bajarildi deb belgilash",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: item.isTaskDone
                                ? const Color(0xFF16A34A)
                                : AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (item.actionLabel != null)
                    GestureDetector(
                      onTap: onTap,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.actionLabel!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 10,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ] else if (item.actionLabel != null) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.actionLabel!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

