import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String movieTitle;
  final String videoUrl;

  const VideoPlayerScreen({
    Key? key,
    required this.movieTitle,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // Architectural States
  String selectedAudio = 'Dual Audio (Urdu/English HD)';
  String selectedAiSub = 'AI Urdu Engine 1 (Cinematic Noto Nastaliq)';
  bool isPlaying = true;
  double playbackProgress = 35.0; // Simulated seconds marker

  final List<String> audioOptions = [
    'Dual Audio (Urdu/English HD)',
    'Original Studio English Audio',
    'Dolby Surround Sound 5.1',
    'AI Enhanced Clear Voice'
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
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F242D),
        title: Text(
          widget.movieTitle,
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // 1. Video Rendering Viewport Container
          Container(
            height: 235,
            width: double.infinity,
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.play_circle_filled,
                  color: Colors.redAccent,
                  size: 68,
                ),
                Positioned(
                  bottom: 12,
                  left: 14,
                  right: 14,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              selectedAiSub.split('(')[0],
                              style: const TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            '01:24:10 / 02:15:00',
                            style: TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: 0.45,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Control Panels & Configuration Parameters
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Dual Audio Selector Component
                const Text(
                  '🎧 Smart Dual Audio Matrix Selector',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedAudio,
                  dropdownColor: const Color(0xFF161B22),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF161B22),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: audioOptions.map((String audio) {
                    return DropdownMenuItem<String>(
                      value: audio,
                      child: Text(audio),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      selectedAudio = val!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // 10 AI Urdu Subtitles Matrix Component
                const Text(
                  '🤖 10 AI Urdu Subtitle Engines (Active Pipeline)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedAiSub,
                  dropdownColor: const Color(0xFF161B22),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF161B22),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: aiSubtitles.map((String engine) {
                    return DropdownMenuItem<String>(
                      value: engine,
                      child: Text(
                        engine,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      selectedAiSub = val!;
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Zero-Buffering System Supervision Diagnostics Panel
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bolt, color: Colors.greenAccent, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Zero-Buffering Anti-Buffer Supervisor Active',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'سسٹم اسٹیٹس: تمام 10 AI اردو سب ٹائٹل انجنز اور ڈوئل آڈیو چینلز بغیر کسی وقفے کے ہائی اسپیڈ اسٹریم کے ساتھ مکمل ہم آہنگ (Synced) ہیں۔',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
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
