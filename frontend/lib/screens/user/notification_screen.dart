import 'package:flutter/material.dart';
import 'package:frontend/widgets/user/bottom_nav_bar.dart';
import 'package:frontend/widgets/user/notification_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> notifications = const [
    {
      'title': 'All Fixed!',
      'message': 'The issue you reported has been resolved. Thank you!',
    },
    {
      'title': 'Thanks for your patience!',
      'message': 'Your report is currently under review.',
    },
    {
      'title': 'We’ve got it!',
      'message': 'Your report has been received and is being reviewed.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Banner
          SizedBox(
            height: 120,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Image.asset('assets/image/banner.png', fit: BoxFit.cover),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Notification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                NotificationButton(),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Notifications List
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (_, __) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFFB3D9F5)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notif['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notif['message']!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/userHome');
          if (index == 1) Navigator.pushNamed(context, '/notification');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}
