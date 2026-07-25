import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const QuantumAegisGodLevelApp());
}

class QuantumAegisGodLevelApp extends StatelessWidget {
  const QuantumAegisGodLevelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Aegis - God Level Core',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF05070B),
        primaryColor: const Color(0xFF6366F1),
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.indigo,
        ).copyWith(
          secondary: const Color(0xFF10B981),
        ),
      ),
      home: const GodLevelDashboard(),
    );
  }
}

// ============================================================================
// GOD LEVEL MASTER DASHBOARD WITH WEBSOCKET & AI MATRIX
// ============================================================================
class GodLevelDashboard extends StatefulWidget {
  const GodLevelDashboard({Key? key}) : super(key: key);

  @override
  State<GodLevelDashboard> createState() => _GodLevelDashboardState();
}

class _GodLevelDashboardState extends State<GodLevelDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const GodServerFeedTab(),
    const GodAudioSubtitleTab(),
    const GodCloudSyncTab(),
    const GodDoctorAiTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0B101D),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF10B981),
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.bolt_rounded), label: 'God Stream'),
            BottomNavigationBarItem(icon: Icon(Icons.graphic_eq_rounded), label: 'Neural Audio'),
            BottomNavigationBarItem(icon: Icon(Icons.hub_rounded), label: 'Live Sync'),
            BottomNavigationBarItem(icon: Icon(Icons.psychology_rounded), label: 'Doctor AI 2.0'),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// TAB 1: GOD STREAM & WEBSOCKET FEED
// ============================================================================
class GodServerFeedTab extends StatefulWidget {
  const GodServerFeedTab({Key? key}) : super(key: key);

  @override
  State<GodServerFeedTab> createState() => _GodServerFeedTabState();
}

class _GodServerFeedTabState extends State<GodServerFeedTab> {
  String wsStatus = "Connecting to WebSocket Neural Core...";
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _initWebSocketSimulation();
  }

  void _initWebSocketSimulation() {
    // گڈ لیول سرور ہینڈ شیک سیمولیشن
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          wsStatus = "WebSocket Active: ws://10.0.2.2:8000/stream/ws";
          isConnected = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          backgroundColor: const Color(0xFF0B101D),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.bolt_rounded, color: Color(0xFF10B981), size: 18),
              ),
              const SizedBox(width: 10),
              const Text('GOD LEVEL STREAM', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: 1)),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // لائیو WebSocket اسٹیٹس کارڈ
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: isConnected ? const Color(0xFF10B981).withOpacity(0.5) : Colors.orange.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 12, color: isConnected ? const Color(0xFF10B981) : Colors.orange),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(wsStatus, style: TextStyle(color: isConnected ? const Color(0xFF10B981) : Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // ہیرو بینر - گاڈ موڈ
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF312E81), Color(0xFF0F766E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF312E81).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
                              child: const Text('GOD MODE • 0% BUFFER LATENCY', style: TextStyle(fontSize: 10, color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 10),
                            const Text('Quantum Neural Genesis Ultra', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            const Text('Powered by Python FastAPI WebSocket & Dual Audio Engine', style: TextStyle(fontSize: 12, color: Colors.white70)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// TAB 2: NEURAL AUDIO & 10 AI SUBTITLE ENGINES
// ============================================================================
class GodAudioSubtitleTab extends StatefulWidget {
  const GodAudioSubtitleTab({Key? key}) : super(key: key);

  @override
  State<GodAudioSubtitleTab> createState() => _GodAudioSubtitleTabState();
}

class _GodAudioSubtitleTabState extends State<GodAudioSubtitleTab> {
  String selectedAudio = "Dolby Atmos Neural Master";
  String selectedEngine = "God Core Master Engine (10/10 Active)";

  final List<String> audioTracks = ["Dolby Atmos Neural Master", "Lossless Spatial Urdu", "English Studio Ultra"];
  final List<String> aiEngines = [
    "God Core Master Engine (10/10 Active)", "Cinematic Noto Nastaliq Pro", "Fast Neural Sync V2",
    "Slang & Pop Culture AI", "Literal Quantum Trans", "Poetic Flow Ultra",
    "Action Optimized Sync", "Ultra Clean Neural Sub", "Smart Contextual AI", "Zero-Latency Stream Core"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Neural Audio & 10 AI Engines', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Spatial Dual Audio Matrix', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF10B981), fontSize: 13)),
          const SizedBox(height: 10),
          ...audioTracks.map((audio) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(12)),
            child: RadioListTile<String>(
              title: Text(audio, style: const TextStyle(fontSize: 13)),
              value: audio,
              groupValue: selectedAudio,
              activeColor: const Color(0xFF10B981),
              onChanged: (val) => setState(() => selectedAudio = val!),
            ),
          )),
          const SizedBox(height: 20),
          const Text('Select AI Subtitle Intelligence', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF10B981), fontSize: 13)),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedEngine,
            dropdownColor: const Color(0xFF0F172A),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF0F172A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: aiEngines.map((engine) => DropdownMenuItem(value: engine, child: Text(engine, style: const TextStyle(fontSize: 12)))) .toList(),
            onChanged: (val) => setState(() => selectedEngine = val!),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 3: CLOUD SYNC & LOCAL CACHE
// ============================================================================
class GodCloudSyncTab extends StatelessWidget {
  const GodCloudSyncTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('God Cloud Sync & Hive Cache', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Real-time Database Stream Progress', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: 0.94, backgroundColor: const Color(0xFF0F172A), color: const Color(0xFF10B981), minHeight: 10),
          const SizedBox(height: 12),
          const Text('Quantum Core Sync — 94% Synced with Python PostgreSQL Backend & Local Hive Storage', style: TextStyle(fontSize: 12, color: Colors.white60)),
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 4: DOCTOR AI 2.0 SELF-HEALING SUPERVISOR
// ============================================================================
class GodDoctorAiTab extends StatefulWidget {
  const GodDoctorAiTab({Key? key}) : super(key: key);

  @override
  State<GodDoctorAiTab> createState() => _GodDoctorAiTabState();
}

class _GodDoctorAiTabState extends State<GodDoctorAiTab> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {"text": "سلام! میں آپ کا گاڈ لیول Doctor AI اسسٹنٹ ہوں۔ تمام سرور نوڈس بالکل پرفیکٹ کام کر رہے ہیں!", "isUser": false},
  ];

  void _sendMessage() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      messages.add({"text": _msgController.text, "isUser": true});
      String userText = _msgController.text;
      _msgController.clear();

      // گاڈ لیول AI آٹومیٹک رسپانس
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() {
            messages.add({
              "text": "ڈاکٹر AI تجزیہ: آپ کے پوتھیان سرور اور ایپ کے درمیان کنکشن مستحکم ہے۔ بفرنگ ریٹ 0% ہے۔",
              "isUser": false
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor AI 2.0 Diagnostics Matrix', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.health_and_safety_rounded, color: Color(0xFF10B981)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text('Self-Healing Active: 0 Buffering Errors. Python WebSocket Secure.',
                        style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: msg['isUser'] ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg['isUser'] ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(msg['text'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    style: const TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Ask God Level Doctor AI...',
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                      filled: true,
                      fillColor: const Color(0xFF0F172A),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.all(12),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
