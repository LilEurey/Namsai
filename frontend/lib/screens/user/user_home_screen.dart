import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/services/report_services.dart';
import 'package:frontend/widgets/user/bottom_nav_bar.dart';
import 'package:frontend/widgets/user/notification_button.dart';
import 'package:frontend/widgets/user/report_card.dart';

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
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Image.asset('assets/image/banner.png', fit: BoxFit.cover),
          ),
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
          Padding(
            padding: const EdgeInsets.only(
              top: 172,
              left: 20,
              right: 20,
              bottom: 80,
            ),
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : reports.isEmpty
                    ? const Center(child: Text('No reports found'))
                    : ListView.separated(
                      itemCount: reports.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final report = reports[index];

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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // handle user navigation
          if (index == 0) Navigator.pushNamed(context, '/userHome');
          if (index == 1) Navigator.pushNamed(context, '/notification');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}
