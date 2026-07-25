import 'package:flutter/material.dart';

// 1. واچ ہسٹری کا ڈیٹا ماڈل (چھوٹی سے چھوٹی تفصیل کے ساتھ)
class WatchHistoryModel {
  final String id;
  final String title;
  final String timestamp;
  final double progress; // 0.0 سے 1.0 تک (مثلاً 0.65 یعنی 65%)
  final String category;
  final String durationLeft;

  WatchHistoryModel({
    required this.id,
    required this.title,
    required this.timestamp,
    required this.progress,
    required this.category,
    required this.durationLeft,
  });
}

// 2. AI ریکمڈیشن انجن سروس
class AISmartRecommendationService {
  static List<Map<String, String>> fetchRecommendations(String filter) {
    List<Map<String, String>> allRecs = [
      {
        "title": "Quantum Odyssey 2026",
        "match": "99% AI Match",
        "genre": "Sci-Fi / Neural",
        "duration": "02:15:00",
        "rating": "9.9"
      },
      {
        "title": "Neural Cyberpunk Urdu",
        "match": "95% AI Match",
        "genre": "Action / Dubbed",
        "duration": "01:50:00",
        "rating": "9.6"
      },
      {
        "title": "The Last Horizon AI",
        "match": "91% AI Match",
        "genre": "Thriller",
        "duration": "02:05:00",
        "rating": "9.4"
      },
      {
        "title": "Matrix Resurrection Urdu",
        "match": "98% AI Match",
        "genre": "Action / Cyber",
        "duration": "02:30:00",
        "rating": "9.8"
      }
    ];

    if (filter == 'All') return allRecs;
    return allRecs.where((item) => item['genre']!.contains(filter)).toList();
  }
}

// 3. مین سکرین وزٹ
class WatchHistoryAndRecommendationsScreen extends StatefulWidget {
  const WatchHistoryAndRecommendationsScreen({Key? key}) : super(key: key);

  @override
  _WatchHistoryAndRecommendationsScreenState createState() =>
      _WatchHistoryAndRecommendationsScreenState();
}

class _WatchHistoryAndRecommendationsScreenState
    extends State<WatchHistoryAndRecommendationsScreen> {
  // فیلٹرز کی لسٹ
  final List<String> filterChips = ['All', 'Sci-Fi', 'Action', 'Thriller'];
  String activeFilter = 'All';

  // ہسٹری لسٹ
  List<WatchHistoryModel> historyList = [
    WatchHistoryModel(
      id: '1',
      title: 'Quantum Matrix 2026',
      timestamp: 'آج، شام 04:20 بجے',
      progress: 0.65,
      category: 'Sci-Fi Odyssey',
      durationLeft: '45 منٹ باقی',
    ),
    WatchHistoryModel(
      id: '2',
      title: 'Cyberpunk Neon Urdu Dubbed',
      timestamp: 'کل، رات 09:15 بجے',
      progress: 1.00,
      category: 'Urdu Dubbed',
      durationLeft: 'مکمل دیکھ لیا گیا',
    ),
    WatchHistoryModel(
      id: '3',
      title: 'The Last Sentinel',
      timestamp: '2 دن پہلے',
      progress: 0.30,
      category: 'Hollywood Action',
      durationLeft: '1 گھنٹہ 30 منٹ باقی',
    ),
  ];

  // ہسٹری کلیئر کرنے کا فنکشن
  void clearHistory() {
    setState(() {
      historyList.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('واچ ہسٹری کامیابی سے صاف کر دی گئی है!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendations = AISmartRecommendationService.fetchRecommendations(activeFilter);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F242D),
        title: const Text(
          '📜 AI ریکمڈیشن اور واچ ہسٹری سنک',
          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
            tooltip: 'ہسٹری صاف کریں',
            onPressed: clearHistory,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // سیکشن 1: فلٹر چپس (ترجیحات بدلنے کے لیے)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterChips.length,
              itemBuilder: (context, index) {
                bool isSelected = activeFilter == filterChips[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filterChips[index]),
                    selected: isSelected,
                    selectedColor: Colors.redAccent,
                    backgroundColor: const Color(0xFF161B22),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        activeFilter = filterChips[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // سیکشن 2: AI اسمارٹ ریکمڈیشن انجن (ہاریزنٹل کارڈز)
          const Text(
            '🤖 AI اسمارٹ ریکمڈیشنز (آپ کی پسند کے مطابق)',
            style: TextStyle(
              color: Colors.yellowAccent,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          recommendations.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('اس کیٹیگری میں کوئی ڈیٹا نہیں ملا',
                        style: TextStyle(color: Colors.white60)),
                  ),
                )
              : SizedBox(
                  id: 'ai_recommendations_scroll',
                  height: 145,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendations.length,
                    itemBuilder: (context, index) {
                      final item = recommendations[index];
                      return Container(
                        width: 190,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B22),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['match']!,
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '⭐ ${item['rating']}',
                                  style: const TextStyle(color: Colors.amber, fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['genre']!,
                              style: const TextStyle(color: Colors.white60, fontSize: 10),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${item['title']} پلے ہو رہی ہے...')),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  '▶ فوراً دیکھیں',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

          const SizedBox(height: 25),

          // سیکشن 3: واچ ہسٹری سنک (ಲಿಸ್ಟ್ ویو)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🕒 آپ کی واچ ہسٹری اور پروگریس',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${historyList.length} ویڈیوز)',
                style: const TextStyle(color: Colors.white60, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),

          historyList.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'آپ کی ہسٹری بالکل خالی ہے۔',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                )
              : Column(
                  children: historyList.map((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B22),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                item.timestamp,
                                style: const TextStyle(color: Colors.white60, fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item.category,
                                  style: const TextStyle(color: Colors.redAccent, fontSize: 9),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.durationLeft,
                                style: const TextStyle(color: Colors.white70, fontSize: 10),
                              ),
                              const Spacer(),
                              Text(
                                item.progress == 1.0
                                    ? 'مکمل'
                                    : '${(item.progress * 100).toInt()}% دیکھا گیا',
                                style: TextStyle(
                                  color: item.progress == 1.0 ? Colors.greenAccent : Colors.amber,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: item.progress,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              item.progress == 1.0 ? Colors.greenAccent : Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
