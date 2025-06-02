import 'package:flutter/material.dart';
import 'package:frontend/widgets/user/bottom_nav_bar.dart';

class UserTipsScreen extends StatefulWidget {
  const UserTipsScreen({Key? key}) : super(key: key);

  @override
  _UserTipsScreenState createState() => _UserTipsScreenState();
}

class _UserTipsScreenState extends State<UserTipsScreen> {
  // 0 = Videos, 1 = Infographics
  int _selectedIndex = 0;

  static const List<_VideoData> _mockVideos = [
    _VideoData(
      thumbnailUrl: 'https://img.youtube.com/vi/zAd1oXbK27E/hqdefault.jpg',
      title: 'SDG 6: CLEAR WATER AND SANITATION',
      channelName: 'MAPFRE',
      channelAvatarUrl:
          'https://yt3.ggpht.com/ytc/AKedOLTN3EXAMPLEAVATAR=s88-c-k-c0x00ffffff-no-rj',
      viewCount: '19K views',
      uploadedAgo: '5 years ago',
      duration: '2:24',
    ),
    _VideoData(
      thumbnailUrl: 'https://img.youtube.com/vi/d8Kp0nFif4Q/hqdefault.jpg',
      title: 'SDG 6: Water-related ecosystems',
      channelName: 'United Nations Water',
      channelAvatarUrl:
          'https://yt3.ggpht.com/ytc/AKedOLUNWEXAMPLEAVATAR=s88-c-k-c0x00ffffff-no-rj',
      viewCount: '280 views',
      uploadedAgo: '6 months ago',
      duration: '1:46',
    ),
  ];

  final List<_InfographicItem> _mockInfographics = const [
    _InfographicItem(
      imageUrl: 'https://via.placeholder.com/400x300.png?text=Info+1',
      title: 'What Are You Really Drinking?',
    ),
    _InfographicItem(
      imageUrl: 'https://via.placeholder.com/400x300.png?text=Info+2',
      title: 'Goal 6: Clean Water and Sanitation',
    ),
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
                      SizedBox(height: 70),
                      Text(
                        'Water Tips',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D334A),
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 2),
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
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
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
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
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

          // Content area: either video list or infographic grid
          Expanded(
            child:
                _selectedIndex == 0
                    ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      itemCount: _mockVideos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        final video = _mockVideos[index];
                        return _VideoCard(video: video);
                      },
                    )
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: _mockInfographics.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.68,
                            ),
                        itemBuilder: (context, index) {
                          final item = _mockInfographics[index];
                          return _InfographicCard(
                            imageUrl: item.imageUrl,
                            title: item.title,
                            onMorePressed: () {},
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
          if (index == 1) Navigator.pushNamed(context, '/userhome');
          if (index == 0) Navigator.pushNamed(context, '/usertips');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}

class _VideoData {
  final String thumbnailUrl;
  final String title;
  final String channelName;
  final String channelAvatarUrl;
  final String viewCount;
  final String uploadedAgo;
  final String duration;

  const _VideoData({
    required this.thumbnailUrl,
    required this.title,
    required this.channelName,
    required this.channelAvatarUrl,
    required this.viewCount,
    required this.uploadedAgo,
    required this.duration,
  });
}

class _VideoCard extends StatelessWidget {
  final _VideoData video;

  const _VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                video.thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, chunk) {
                  if (chunk == null) return child;
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
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
            Positioned(
              top: 8,
              right: 8,
              child: Column(
                children: const [
                  Icon(Icons.volume_off, color: Colors.white, size: 20),
                  SizedBox(height: 4),
                  Icon(Icons.closed_caption, color: Colors.white, size: 20),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                color: Colors.black.withOpacity(0.7),
                child: Text(
                  video.duration,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(video.channelAvatarUrl),
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${video.channelName} • ${video.viewCount} • ${video.uploadedAgo}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfographicItem {
  final String imageUrl;
  final String title;

  const _InfographicItem({required this.imageUrl, required this.title});
}

class _InfographicCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onMorePressed;

  const _InfographicCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // รูป Infographic
          Expanded(
            flex: 7,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, chunk) {
                if (chunk == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (_, __, ___) {
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

          // ชื่อ Infographic + ปุ่ม more
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: onMorePressed,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
