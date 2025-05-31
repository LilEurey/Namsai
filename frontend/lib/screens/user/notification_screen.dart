import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import 'package:frontend/widgets/notification_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedIndex = 1;

  final List<Map<String, String>> notifications = [
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

  void onBottomNavTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Navigation based on index
    if (index == 0) {
      Navigator.pushNamed(context, '/usertips');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/userhome');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/userprofile');
    }
  }

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

          // Title & bell
          SafeArea(
            child: Padding(
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
          ),

          const SizedBox(height: 8),

          // Notifications list
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

      // Bottom nav bar
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onBottomNavTap,
      ),
    );
  }
}
