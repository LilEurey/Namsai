// lib/screens/user_home_screen.dart

import 'package:flutter/material.dart';
import 'package:frontend/widgets/user/report_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/services/report_services.dart';
import 'package:frontend/widgets/user/bottom_nav_bar.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List<Map<String, dynamic>> reports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('User not logged in');
      }

      final fetchedReports = await ReportService.getUserReports(token);

      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      print('❌ Error fetching reports: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1) Banner image at the very top
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Image.asset('assets/image/banner.png', fit: BoxFit.cover),
          ),

          // 2) Header row: “My Reports” (remove bell icon)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: const Text(
                'My Reports',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  shadows: [Shadow(color: Colors.white70, blurRadius: 2)],
                ),
              ),
            ),
          ),

          // 3) Report list
          Padding(
            padding: const EdgeInsets.only(
              top: 172,
              left: 20,
              right: 20,
              // bottom: 90, // removed so background extends to bottom
            ),
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : reports.isEmpty
                    ? const Center(child: Text('No reports found'))
                    : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 90),
                      itemCount: reports.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final report = reports[index];

                        // Format updatedAt into Thailand time
                        String updatedAtFormatted = 'Unknown';
                        try {
                          final rawDate = report['updatedAt'];
                          final thailandTime = DateTime.parse(
                            rawDate,
                          ).toUtc().add(const Duration(hours: 7));
                          updatedAtFormatted =
                              '${thailandTime.year}-${thailandTime.month.toString().padLeft(2, '0')}-${thailandTime.day.toString().padLeft(2, '0')} '
                              '${thailandTime.hour.toString().padLeft(2, '0')}:${thailandTime.minute.toString().padLeft(2, '0')}';
                        } catch (_) {}

                        // Parse coordinates safely
                        final coordinates = <double>[0.0, 0.0];
                        try {
                          final coords = report['coordinates']?['coordinates'];
                          if (coords is List) {
                            coordinates.clear();
                            for (final e in coords) {
                              coordinates.add((e as num).toDouble());
                            }
                          }
                        } catch (_) {}

                        return ReportCard(
                          name: report['createdBy']?['name'] ?? 'Unknown',
                          water_type: report['water_type'] ?? 'Water report',
                          detail: report['detail'] ?? 'No description',
                          status: report['status'] ?? 'Pending',
                          updatedAt: updatedAtFormatted,
                          coordinates: coordinates,
                        );
                      },
                    ),
          ),

          // 4) Circular “+” icon (custom Container instead of FloatingActionButton)
          Positioned(
            bottom: 60, // position just above the BottomNavBar
            right: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/reportStep1');
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white, // background circle is white
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(60, 0, 0, 0),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 28,
                    color: Color(0xFF59A5D8), // “+” is blue
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // 5) Custom BottomNavBar at the bottom
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/userhome');
          if (index == 0) Navigator.pushNamed(context, '/usertips');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}
