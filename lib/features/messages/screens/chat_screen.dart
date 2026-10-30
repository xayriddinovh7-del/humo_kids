import 'package:flutter/material.dart';
import 'package:humo_kids/core/constants/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.name = 'Mohira Karimova',
    this.role = '1-guruh tarbiyachisi',
    this.subject = 'Amirbek haqida suhbat',
    this.hours = '08:00–18:00',
  });

  final String name;
  final String role;
  final String subject;
  final String hours;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_Message> _messages = const [
    _Message(
      text: "Assalomu alaykum, Mohira opa! Amirbek bugun nonushtani yaxshi yedimi?",
      isMe: true,
      time: '09:10',
    ),
    _Message(
      text: "Va alaykum assalom, Dilnoza! Ha, suli bo'tqasining 90% ini yedi. Kayfiyati ham juda yaxshi.",
      isMe: false,
      time: '09:15',
    ),
    _Message(
      text: "Rahmat! Kecha biroz kech uxlagandi. Uyqusini ham aytib yuboring, iltimos.",
      isMe: true,
      time: '09:17',
    ),
    _Message(
      text: "Albatta. Bugun 12:45 dan 14:15 gacha tinch uxladi. Mashg'ulotlarda faol qatnashdi.",
      isMe: false,
      time: '14:20',
    ),
  ];

  final List<_Message> _dynamicMessages = [];

  @override
  void initState() {
    super.initState();
    _dynamicMessages.addAll(_messages);
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _dynamicMessages.add(_Message(
        text: text,
        isMe: true,
        time: _nowTime(),
      ));
      _msgController.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _nowTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

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
                // ── App Bar ──
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 24,
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Avatar
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: const Color(0xFFE8F8EE),
                        child: Text(
                          widget.name
                              .split(' ')
                              .take(2)
                              .map((e) => e[0])
                              .join(),
                          style: const TextStyle(
                            color: Color(0xFF16A34A),
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.darkText,
                              ),
                            ),
                            Text(
                              widget.role,
                              style: const TextStyle(
                                fontSize: 12,
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
                              content: Text("Qo'ng'iroq qilinmoqda..."),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.call_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Subject banner ──
                Container(
                  width: double.infinity,
                  color: const Color(0xFFF0F5FF),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.topic_rounded,
                          size: 15, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "${widget.subject}   ·   Ish vaqti ${widget.hours}",
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Messages ──
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _dynamicMessages.length + 1,
                    itemBuilder: (context, index) {
                      // Date separator
                      if (index == 0) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Bugun, 23-oktabr",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.grayText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      final msg = _dynamicMessages[index - 1];
                      return _MessageBubble(message: msg);
                    },
                  ),
                ),

                // ── Photo card (attachment preview) ──
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEDF2F7)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 52,
                          height: 52,
                          color: const Color(0xFFDCFCE7),
                          child: const Icon(
                            Icons.image_rounded,
                            color: Color(0xFF16A34A),
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Kuzgi rasmni sizga ko'rsatishga oshiqapti!",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grayText,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Input bar ──
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.add_circle_outline_rounded,
                          color: AppColors.grayText,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            controller: _msgController,
                            style: const TextStyle(fontSize: 14),
                            onSubmitted: (_) => _sendMessage(),
                            decoration: const InputDecoration(
                              hintText: "Xabar yozing...",
                              hintStyle: TextStyle(
                                color: AppColors.grayText,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 20,
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

class _Message {
  const _Message({
    required this.text,
    required this.isMe,
    required this.time,
    this.imageAsset,
  });

  final String text;
  final bool isMe;
  final String time;
  final String? imageAsset;
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final _Message message;

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xFFE8F8EE),
              child: const Text(
                'MK',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF16A34A),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: isMe
                          ? const Radius.circular(18)
                          : const Radius.circular(4),
                      bottomRight: isMe
                          ? const Radius.circular(4)
                          : const Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(maxWidth: 260),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: isMe ? Colors.white : AppColors.darkText,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.grayText,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      const Text(
                        "O'qildi",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.grayText,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 4),
        ],
      ),
    );
  }
}

