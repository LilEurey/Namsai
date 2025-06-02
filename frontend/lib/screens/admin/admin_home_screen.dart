import 'package:flutter/material.dart';
import 'package:frontend/widgets/admin/bottom_nav_bar.dart';
import 'package:frontend/services/report_services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> allReports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _loadReports();
  }

  Future<void> _loadReports() async {
    try {
      final fetchedReports = await ReportService.fetchReports();
      setState(() {
        allReports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching reports: $e');
      setState(() => isLoading = false);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.lightBlue;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusChip(String status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 4),
          Text(status, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filterReports(String status) {
    return allReports.where((r) => r['status'] == status).toList();
  }

  int getPendingCount() => _filterReports('Pending').length;
  int getInProgressCount() => _filterReports('In Progress').length;
  int getCompletedCount() => _filterReports('Completed').length;

  Widget _buildTabWithBadge(String label, int count, int index) {
    final isSelected = _tabController.index == index;
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(width: 4),
          if (count > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMap(double lat, double lng) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 80,
        width: 80,
        child: FlutterMap(
          options: MapOptions(initialCenter: LatLng(lat, lng), initialZoom: 13),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(lat, lng),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_pin, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    final name = report['createdBy']?['name'] ?? 'Unknown';
    final title = 'Water type: ${report['water_type'] ?? 'N/A'}';
    final description = report['detail'] ?? 'No description';
    final updatedAt = report['updatedAt'] ?? '';
    final date = updatedAt.toString().split('T')[0];
    final status = report['status'] ?? 'Pending';
    final coords = report['coordinates']?['coordinates'];
    double lat = 13.652;
    double lng = 100.494;

    if (coords is List && coords.length == 2) {
      final lngValue = coords[0];
      final latValue = coords[1];

      if (lngValue is num && latValue is num) {
        lng = lngValue.toDouble();
        lat = latValue.toDouble();
      } else if (lngValue is String && latValue is String) {
        lng = double.tryParse(lngValue) ?? lng;
        lat = double.tryParse(latValue) ?? lat;
      }
    }

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          '/adminreport',
          arguments: report,
        );

        if (result == true) {
          _loadReports();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFD9EBFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _buildMap(lat, lng),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: _buildStatusChip(status),
                  ),
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text('"$description"'),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Updated: $date',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportList(List<Map<String, dynamic>> reports) {
    if (reports.isEmpty) {
      return const Center(child: Text('No reports found.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: reports.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildReportCard(reports[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        child: Image.asset(
                          'assets/image/banner.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'All Reports',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.black87,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blue,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        _buildTabWithBadge('Pending', getPendingCount(), 0),
                        _buildTabWithBadge(
                          'In Progress',
                          getInProgressCount(),
                          1,
                        ),
                        _buildTabWithBadge('Completed', getCompletedCount(), 2),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildReportList(_filterReports('Pending')),
                          _buildReportList(_filterReports('In Progress')),
                          _buildReportList(_filterReports('Completed')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/adminreport');
          if (index == 1) Navigator.pushNamed(context, '/adminhome');
          if (index == 2) Navigator.pushNamed(context, '/adminprofile');
        },
      ),
    );
  }
}
