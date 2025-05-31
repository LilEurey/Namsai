import 'package:flutter/material.dart';
import 'package:frontend/widgets/user/bottom_nav_bar.dart';
import 'package:frontend/widgets/user/notification_button.dart';
import 'package:frontend/widgets/user/report_card.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Banner image
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Image.asset('assets/image/banner.png', fit: BoxFit.cover),
          ),

          // Title + Notification button
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

          // Report list
          Padding(
            padding: const EdgeInsets.only(top: 172, left: 20, right: 20, bottom: 80),
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

          // Add Report FAB
          Positioned(
            bottom: 90,
            right: 24,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF7CB8E2),
              onPressed: () {
                Navigator.pushNamed(context, '/reportStep1');
              },
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}