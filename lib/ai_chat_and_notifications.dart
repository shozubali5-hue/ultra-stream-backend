import 'package:flutter/material.dart';

// ==========================================
// 1. GOD-LEVEL CHAT & NOTIFICATION MODELS
// ==========================================

class GodChatMessageModel {
  final String id;
  final String text;
  final bool isUser;
  final String timestamp;

  GodChatMessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class GodNotificationModel {
  final String id;
  final String title;
  final String body;
  final String timestamp;
  bool isRead;

  GodNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });
}

// ==========================================
// 2. GOD-LEVEL AI CHAT & NOTIFICATIONS SCREEN
// ==========================================

class GodAIChatAndNotificationsScreen extends StatefulWidget {
  const GodAIChatAndNotificationsScreen({Key? key}) : super(key: key);

  @override
  _GodAIChatAndNotificationsScreenState createState() =>
      _GodAIChatAndNotificationsScreenState();
}

class _GodAIChatAndNotificationsScreenState
    extends State<GodAIChatAndNotificationsScreen> {
  final TextEditingController _msgController = TextEditingController();

  // لائیو چیٹ پیغامات کا اسٹیٹ
  final List<GodChatMessageModel> _chatMessages = [
    GodChatMessageModel(
      id: 'msg_1',
      text: 'السلام علیکم! میں آپ کا گارڈ لیول AI اسسٹنٹ ہوں۔ بتائیں کون سی مووی، ڈوئل آڈیو یا 10 AI سب ٹائٹل انجن کے بارے میں مدد چاہیے؟',
      isUser: false,
      timestamp: '04:00 PM',
    ),
  ];

  // پش نوٹیفکیشنز کا اسٹیٹ
  final List<GodNotificationModel> _notifications = [
    GodNotificationModel(
      id: 'notif_1',
      title: '⚡ نئی گارڈ-لیول مووی ریلیز!',
      body: 'Quantum Matrix 2026 اب ڈوئل آڈیو اور تمام 10 AI سب ٹائٹل انجنز کے ساتھ لائیو ہے۔',
      timestamp: '10 منٹ پہلے',
    ),
    GodNotificationModel(
      id: 'notif_2',
      title: '🤖 AI سب ٹائٹل انجن اپ ڈیٹ',
      body: 'Engine 1 (Cinematic Noto Nastaliq) میں نیورل سنک کو مزید تیز کر دیا گیا ہے۔',
      timestamp: '1 گھنٹہ پہلے',
    ),
  ];

  // میسج بھیجنے کا گارڈ-لیول فنکشن
  void _dispatchMessage() {
    if (_msgController.text.trim().isEmpty) return;

    String userText = _msgController.text;
    setState(() {
      _chatMessages.add(
        GodChatMessageModel(
          id: DateTime.now().toString(),
          text: userText,
          isUser: true,
          timestamp: 'ابھی',
        ),
      );
      _msgController.clear();
    });

    // AI رسپانس سیمুলেషన్
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _chatMessages.add(
          GodChatMessageModel(
            id: DateTime.now().toString(),
            text: 'AI کور: آپ کی کمانڈ "$userText" کامیابی سے پروسیس ہو گئی ہے۔ تمام سب ٹائٹل اور آڈیو چینلز سنک ہیں۔',
            isUser: false,
            timestamp: 'ابھی',
          ),
        );
      });
    });
  }

  // نوٹیفکیشن کلیئر کرنے کا فنکشن
  void _clearNotifications() {
    setState(() {
      _notifications.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⚡ تمام نوٹیفکیشنز صاف کر دیے گئے ہیں!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF05070B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F141D),
          title: const Text(
            '⚡ GOD-LEVEL AI CHAT & NOTIFICATIONS',
            style: TextStyle(
                fontSize: 11, color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.clear_all, color: Colors.redAccent),
              tooltip: 'نوٹیفکیشنز صاف کریں',
              onPressed: _clearNotifications,
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.redAccent,
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Neural AI Chat'),
              Tab(icon: Icon(Icons.notifications_active), text: 'Live Alerts'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ==========================================
            // TAB 1: NEURAL AI LIVE CHAT INTERFACE
            // ==========================================
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: _chatMessages.length,
                    itemBuilder: (context, index) {
                      final msg = _chatMessages[index];
                      return Align(
                        alignment: msg.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? Colors.redAccent
                                : const Color(0xFF10151D),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: msg.isUser
                                  ? Colors.transparent
                                  : Colors.redAccent.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                msg.timestamp,
                                style: TextStyle(
                                  color: msg.isUser
                                      ? Colors.white70
                                      : Colors.white38,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFF0F141D),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          decoration: const InputDecoration(
                            hintText: 'گارڈ-لیول AI سے کچھ پوچھیں...',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.redAccent),
                        onPressed: _dispatchMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ==========================================
            // TAB 2: LIVE PUSH NOTIFICATIONS CORE
            // ==========================================
            _notifications.isEmpty
                ? const Center(
                    child: Text(
                      'کوئی نیا نوٹیفکیشن موجود نہیں ہے۔',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notif = _notifications[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10151D),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.redAccent.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  notif.title,
                                  style: const TextStyle(
                                    color: Colors.yellowAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  notif.timestamp,
                                  style: const TextStyle(
                                      color: Colors.white60, fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              notif.body,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 11),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
