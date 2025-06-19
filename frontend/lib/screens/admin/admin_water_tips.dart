import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:frontend/widgets/admin/bottom_nav_bar.dart';

class AdminTipsScreen extends StatefulWidget {
  const AdminTipsScreen({Key? key}) : super(key: key);

  @override
  _AdminTipsScreenState createState() => _AdminTipsScreenState();
}

class _AdminTipsScreenState extends State<AdminTipsScreen> {
  // 0 = Videos, 1 = Infographics
  int _selectedIndex = 0;

  // รายการ YouTube URLs
  static const List<String> _videoUrls = [
    'https://youtu.be/t6FiJr_J1qI?si=ZGyoQoik4iJtai05',
    'https://youtu.be/dpaUBRl8c6A?si=g4Fz6BOvTa20TW4n',
    'https://youtu.be/DhLVCuuImT0?si=Lptdh_tsk3NkRVh2',
    'https://youtu.be/nhGnqlsfx2k?si=BD0d3A41IppY-CoF',
    'https://youtu.be/T04rCU25YmA?si=bJgKFpoj-9UJ-rp1',
  ];

  String _extractVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return '';
    if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.first;
    }
    return '';
  }

  String _thumbnailForId(String id) =>
      'https://img.youtube.com/vi/$id/hqdefault.jpg';

  // ลิสต์ Infographics ที่แก้ให้ Info2 กับ Info7 เป็น .PNG
  final List<String> _assetInfographics = [
    'assets/image/Info1.JPG',
    'assets/image/Info2.PNG',
    'assets/image/Info3.JPG',
    'assets/image/Info4.JPG',
    'assets/image/Info5.JPG',
    'assets/image/Info6.JPG',
    'assets/image/Info7.PNG',
    'assets/image/Info8.JPG',
    'assets/image/Info9.JPG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner + Title
          Stack(
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Image.asset(
                  'assets/image/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 80),
                      Text(
                        'Water Tips',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          shadows: [
                            Shadow(color: Colors.white70, blurRadius: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Custom “tab” header: Videos / Infographics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Videos tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Videos',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  _selectedIndex == 0
                                      ? const Color(0xFF4A90E2)
                                      : Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (_selectedIndex == 0)
                            Container(
                              height: 2,
                              width: 100,
                              color: const Color(0xFF4A90E2),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Infographics tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 1),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Infographics',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  _selectedIndex == 1
                                      ? const Color(0xFF4A90E2)
                                      : Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (_selectedIndex == 1)
                            Container(
                              height: 2,
                              width: 100,
                              color: const Color(0xFF4A90E2),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Content area: Videos หรือ Infographics
          Expanded(
            child:
                _selectedIndex == 0
                    // ─────────── Videos ───────────
                    ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: ListView.separated(
                        itemCount: _videoUrls.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          final url = _videoUrls[index];
                          final videoId = _extractVideoId(url);
                          final thumbUrl = _thumbnailForId(videoId);

                          return GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Could not open the video link.',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          thumbUrl,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            chunk,
                                          ) {
                                            if (chunk == null) return child;
                                            return Container(
                                              color: Colors.grey.shade200,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Container(
                                              color: Colors.grey.shade200,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.broken_image,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: 48,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Video ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                    // ─────────── Infographics ───────────
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: _assetInfographics.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.0,
                            ),
                        itemBuilder: (context, index) {
                          final assetPath = _assetInfographics[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(
                              assetPath,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => Container(
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/adminhome');
          if (index == 0) Navigator.pushNamed(context, '/admintips');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}
