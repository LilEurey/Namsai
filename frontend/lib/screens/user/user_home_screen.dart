import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import 'package:frontend/widgets/notification_button.dart';
import 'package:frontend/widgets/report_card.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int selectedIndex = 1; // Home tab selected

  final List<Map<String, dynamic>> reports = const [
    {
      'name': 'Krit Tacho',
      'title': 'Smelly water issue reported',
      'description':
          'The water in this area smells unpleasant and appears polluted. Please investigate the source.',
      'date': 'May 26, 2025',
      'status': 'In Progress',
      'mapImage': 'assets/image/Maps.png',
    },
    {
      'name': 'Krit Tacho',
      'title': 'Smelly water issue reported',
      'description':
          'The water in this area smells unpleasant and appears polluted. Please investigate the source.',
      'date': 'May 26, 2025',
      'status': 'Pending',
      'mapImage': 'assets/image/Maps.png',
    },
    {
      'name': 'Krit Tacho',
      'title': 'Smelly water issue reported',
      'description':
          'The water in this area smells unpleasant and appears polluted. Please investigate the source.',
      'date': 'May 26, 2025',
      'status': 'Pending',
      'mapImage': 'assets/image/Maps.png',
    },
    {
      'name': 'Krit Tacho',
      'title': 'Smelly water issue reported',
      'description':
          'The water in this area smells unpleasant and appears polluted. Please investigate the source.',
      'date': 'May 26, 2025',
      'status': 'Pending',
      'mapImage': 'assets/image/Maps.png',
    },
  ];

  void onBottomNavTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    // TODO: Navigation logic if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Banner Image at the top
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Image.asset('assets/image/banner.png', fit: BoxFit.cover),
          ),

          // Overlay for title and notification button on banner
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'My Reports',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      shadows: [Shadow(color: Colors.white70, blurRadius: 2)],
                    ),
                  ),
                  NotificationButton(),
                ],
              ),
            ),
          ),

          // Reports list below the banner
          Padding(
            padding: const EdgeInsets.only(
              top: 160 + 12,
              left: 20,
              right: 20,
              bottom: 80,
            ),
            child: ListView.separated(
              itemCount: reports.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final report = reports[index];
                return ReportCard(
                  name: report['name'],
                  title: report['title'],
                  description: report['description'],
                  status: report['status'],
                  date: report['date'],
                  mapImage: report['mapImage'],
                );
              },
            ),
          ),

          // Floating Action Button bottom right
          Positioned(
            bottom: 90,
            right: 24,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF7CB8E2),
              onPressed: () {
                // TODO: Add your action here
              },
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onBottomNavTap,
        currentIndex: null,
      ),
    );
  }
}
