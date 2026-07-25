import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const GodLevelQuantumAegisApp());
}

class GodLevelQuantumAegisApp extends StatelessWidget {
  const GodLevelQuantumAegisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Aegis Ultra Pro Max - God Level',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.redAccent,
        scaffoldBackgroundColor: const Color(0xFF05070B),
        cardColor: const Color(0xFF10151D),
      ),
      home: const MasterGodNavigationHub(),
    );
  }
}

class MasterGodNavigationHub extends StatefulWidget {
  const MasterGodNavigationHub({Key? key}) : super(key: key);

  @override
  _MasterGodNavigationHubState createState() => _MasterGodNavigationHubState();
}

class _MasterGodNavigationHubState extends State<MasterGodNavigationHub> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const GodDashboardTab(),
    const GodRecommendationsTab(),
    const GodAIChatTab(),
    const GodNotificationsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F141D),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Quantum Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI Sync'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Neural Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Alerts'),
        ],
      ),
    );
  }
}

// ==================== TAB 1: GOD-LEVEL MASTER DASHBOARD ====================

class GodDashboardTab extends StatefulWidget {
  const GodDashboardTab({Key? key}) : super(key: key);

  @override
  _GodDashboardTabState createState() => _GodDashboardTabState();
}

class _GodDashboardTabState extends State<GodDashboardTab> {
  String activeCategory = 'Trending 2026';
  List catalogList = [
    {
      "title": "Quantum Matrix Genesis 2026",
      "year": "2026",
      "rating": "9.9",
      "url": "https://www.w3schools.com/html/mov_bbb.mp4",
      "badge": "Dual Audio / 10 AI Engines"
    },
    {
      "title": "Neural Cyberpunk Urdu Master",
      "year": "2025",
      "rating": "9.7",
      "url": "https://www.w3schools.com/html/mov_bbb.mp4",
      "badge": "Neural Sync / Dolby 5.1"
    },
    {
      "title": "The Last Sentinel Horizon",
      "year": "2024",
      "rating": "9.4",
      "url": "https://www.w3schools.com/html/mov_bbb.mp4",
      "badge": "Ultra Clean / 4K Stream"
    }
  ];

  final List<String> categories = [
    'Trending 2026',
    'Hollywood Action',
    'Urdu Dubbed',
    'Anime HD',
    'Sci-Fi Odyssey'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F141D),
        title: const Text(
          '⚡ QUANTUM AEGIS: GOD-LEVEL CORE',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isSelected = activeCategory == categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: isSelected,
                    selectedColor: Colors.redAccent,
                    backgroundColor: const Color(0xFF10151D),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (bool selected) {
                      setState(() => activeCategory = categories[index]);
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: catalogList.length,
              itemBuilder: (context, index) {
                final item = catalogList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GodVideoPlayerScreen(
                          movieTitle: item['title'],
                          videoUrl: item['url'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF10151D),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            ),
                            child: const Center(
                              child: Icon(Icons.play_circle_fill, color: Colors.redAccent, size: 45),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('⭐ ${item['rating']}', style: const TextStyle(fontSize: 10, color: Colors.amber)),
                                  Text(item['year'], style: const TextStyle(fontSize: 10, color: Colors.white60)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['badge'],
                                style: const TextStyle(fontSize: 9, color: Colors.redAccent, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== GOD-LEVEL VIDEO PLAYER SCREEN ====================

class GodVideoPlayerScreen extends StatefulWidget {
  final String movieTitle;
  final String videoUrl;

  const GodVideoPlayerScreen({Key? key, required this.movieTitle, required this.videoUrl}) : super(key: key);

  @override
  _GodVideoPlayerScreenState createState() => _GodVideoPlayerScreenState();
}

class _GodVideoPlayerScreenState extends State<GodVideoPlayerScreen> {
  String selectedAudio = 'Dual Audio (Urdu/English Ultra HD)';
  String selectedAiSub = 'AI Urdu Engine 1 (Cinematic Noto Nastaliq)';

  final List<String> audioOptions = [
    'Dual Audio (Urdu/English Ultra HD)',
    'Original Studio Master Audio',
    'Dolby Atmos 7.1 Surround',
    'AI Neural Voice Clarity'
  ];

  final List<String> aiSubtitles = [
    'AI Urdu Engine 1 (Cinematic Noto Nastaliq)',
    'AI Urdu Engine 2 (Fast Neural Sync)',
    'AI Urdu Engine 3 (Classic Dub Script)',
    'AI Urdu Engine 4 (Slang & Pop Culture)',
    'AI Urdu Engine 5 (Literal Translation)',
    'AI Urdu Engine 6 (Poetic Flow)',
    'AI Urdu Engine 7 (Action Optimized)',
    'AI Urdu Engine 8 (Ultra Clean Sub)',
    'AI Urdu Engine 9 (Smart Contextual)',
    'AI Urdu Engine 10 (Master AI Core)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F141D),
        title: Text(widget.movieTitle, style: const TextStyle(fontSize: 14, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            color: const Color(0xFF090C10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.play_circle_filled, color: Colors.redAccent, size: 65),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        color: Colors.black87,
                        child: Text(
                          selectedAiSub.split('(')[0],
                          style: const TextStyle(color: Colors.yellowAccent, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text('01:24:10 / 02:15:00', style: TextStyle(color: Colors.white70, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                const Text('🎧 God-Level Smart Dual Audio Matrix', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedAudio,
                  dropdownColor: const Color(0xFF10151D),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF10151D),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  items: audioOptions.map((a) => DropdownMenuItem(value: a, child: Text(a))).toList(),
                  onChanged: (val) => setState(() => selectedAudio = val!),
                ),
                const SizedBox(height: 18),
                const Text('🤖 10 AI Urdu Subtitle Engines (Active Pipeline)', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedAiSub,
                  dropdownColor: const Color(0xFF10151D),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF10151D),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  items: aiSubtitles.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 11)))).toList(),
                  onChanged: (val) => setState(() => selectedAiSub = val!),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10151D),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
                  ),
                  child: const Text(
                    '⚡ Zero-Buffering Anti-Buffer Supervisor: فعال۔ تمام 10 AI انجنز ہائی اسپیڈ اسٹریم کے ساتھ مکمل سنکرونائز ہیں۔',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold),
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

// ==================== TAB 2: RECOMMENDATIONS & HISTORY ====================

class GodRecommendationsTab extends StatelessWidget {
  const GodRecommendationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F141D),
        title: const Text('🤖 AI Smart Recommendations & Watch History', style: TextStyle(fontSize: 13, color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Text('🔥 AI Predicted For You (99% Match)', style: TextStyle(color: Colors.yellowAccent, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecCard('Quantum Odyssey', '99% AI Match', 'Sci-Fi'),
                _buildRecCard('Neural Cyberpunk', '96% AI Match', 'Action'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('🕒 Synchronized Watch History', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildHistoryCard('Quantum Matrix 2026', '65% Watched', Colors.redAccent),
          _buildHistoryCard('Cyberpunk Neon Urdu', '100% Completed', Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _buildRecCard(String title, String match, String genre) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFF10151D), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(match, style: const TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(genre, style: const TextStyle(color: Colors.white60, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String title, String progress, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFF10151D), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          Text(progress, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==================== TAB 3: NEURAL AI CHAT ASSISTANT ====================

class GodAIChatTab extends StatefulWidget {
  const GodAIChatTab({Key? key}) : super(key: key);

  @override
  _GodAIChatTabState createState() => _GodAIChatTabState();
}

class _GodAIChatTabState extends State<GodAIChatTab> {
  final TextEditingController _ctrl = TextEditingController();
  final List<String> _chats = ['السلام علیکم! میں آپ کا گارڈ لیول AI اسسٹنٹ ہوں۔ بتائیں کیا مدد کروں؟'];

  void _send() {
    if (_ctrl.text.isEmpty) return;
    setState(() {
      _chats.add('یوزر: ${_ctrl.text}');
      _chats.add('AI: آپ کی کمانڈ کامیابی سے پروسیس ہو گئی ہے۔');
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F141D),
        title: const Text('💬 God-Level Neural AI Chat', style: TextStyle(fontSize: 13, color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFF10151D), borderRadius: BorderRadius.circular(8)),
                  child: Text(_chats[index], style: const TextStyle(color: Colors.white, fontSize: 12)),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF0F141D),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _ctrl, style: const TextStyle(color: Colors.white, fontSize: 12), decoration: const InputDecoration(hintText: 'AI سے پوچھیں...', border: InputBorder.none))),
                IconButton(icon: const Icon(Icons.send, color: Colors.redAccent), onPressed: _send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== TAB 4: REAL-TIME NOTIFICATIONS ====================

class GodNotificationsTab extends StatelessWidget {
  const GodNotificationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F141D),
        title: const Text('🔔 Live Push Notifications Core', style: TextStyle(fontSize: 13, color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF10151D), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.redAccent.withOpacity(0.3))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
   
