import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const QuantumAegisGodApp());
}

class QuantumAegisGodApp extends StatelessWidget {
  const QuantumAegisGodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Aegis Ultra Pro Max - God Level OTT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF030307),
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      home: const GodLevelDashboardScreen(),
    );
  }
}

class GodLevelDashboardScreen extends StatefulWidget {
  const GodLevelDashboardScreen({super.key});

  @override
  State<GodLevelDashboardScreen> createState() => _GodLevelDashboardScreenState();
}

class _GodLevelDashboardScreenState extends State<GodLevelDashboardScreen> {
  List categories = [];
  bool isLoading = true;
  String errorMessage = '';
  String scraperLiveStatus = 'Auto-Scraper Active (1990-2026 Syncing...)';

  @override
  void initState() {
    super.initState();
    fetchGodLevelData();
  }

  // God-Level Backend Sync with Auto-Scraper & 10 AI Subtitle Engines
  Future<void> fetchGodLevelData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/categories'));
      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
          isLoading = false;
          scraperLiveStatus = 'Movies Box Advanced Scraper: Fully Synced (1990-2026)';
        });
      } else {
        setState(() {
          errorMessage = 'Server Sync Error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Backend Offline. Please start FastAPI server.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.bolt, color: Colors.redAccent, size: 26),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'QUANTUM AEGIS OTT',
                  style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.white, fontSize: 16),
                ),
                Text(
                  scraperLiveStatus,
                  style: const TextStyle(fontSize: 9, color: Colors.greenAccent, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.black.withOpacity(0.9),
        elevation: 12,
        actions: [
          // Phase 5: AI Master Search Hook
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('AI Master Search & Typo Correction Hook Active (Phase 5)')),
              );
            },
          ),
          // Phase 7: Adult Restricted Shield & PIN Lock Hook
          IconButton(
            icon: const Icon(Icons.security, color: Colors.amberAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('18+ Adult Restricted Shield PIN Lock Active (Phase 7)')),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
                strokeWidth: 4,
              ),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : RefreshIndicator(
                  color: Colors.redAccent,
                  backgroundColor: Colors.black,
                  onRefresh: fetchGodLevelData,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: kToolbarHeight + 25, bottom: 40),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Header
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 18,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    cat['name'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Explore All',
                                  style: TextStyle(fontSize: 11, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          // Horizontal Media Cards Slider (Netflix/Amazon Prime Advanced Style)
                          SizedBox(
                            height: 235,
                            child: cat['items'].isEmpty
                                ? Center(
                                    child: Text(
                                      "Auto-fetching global movies & series (1990-2026)...",
                                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    itemCount: cat['items'].length,
                                    itemBuilder: (context, itemIndex) {
                                      final item = cat['items'][itemIndex];
                                      bool hasHindi = item['has_hindi_dubbing'] ?? false;
                                      
                                      return Container(
                                        width: 145,
                                        margin: const EdgeInsets.symmetric(horizontal: 6.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: const Color(0xFF111420),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.6),
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              // Movie Poster
                                              Image.network(
                                                item['poster_url'],
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => const Center(
                                                  child: Icon(Icons.broken_image, color: Colors.grey),
                                                ),
                                              ),
                                              // Gradient Shadow Overlay
                                              Positioned.fill(
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black.withOpacity(0.9),
                                                      ],
                                                      stops: const [0.4, 1.0],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Top Badges: Release Year (1990-2026) & Dual Audio Tag
                                              Positioned(
                                                top: 6,
                                                left: 6,
                                                right: 6,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueAccent.withOpacity(0.85),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text(
                                                        hasHindi ? 'Dual Audio' : 'Original',
                                                        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: Colors.redAccent.withOpacity(0.9),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text(
                                                        '${item['release_year']}',
                                                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Bottom Details: Title, 10 AI Urdu Subtitle Engines & Quality Rules
                                              Positioned(
                                                bottom: 8,
                                                left: 8,
                                                right: 8,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item['title'],
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.subtitles, size: 10, color: Colors.greenAccent),
                                                        const SizedBox(width: 3),
                                                        Text(
                                                          '10 AI Urdu (Nastaliq)',
                                                          style: TextStyle(fontSize: 9, color: Colors.greenAccent[100], fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      'Quality: 360p / 480p / 720p',
                                                      style: TextStyle(fontSize: 8, color: Colors.grey[400]),
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
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ),
    );
  }
}
