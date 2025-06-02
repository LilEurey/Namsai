import 'package:flutter/material.dart';
import 'package:frontend/widgets/admin/bottom_nav_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 1;

  final List<Map<String, dynamic>> reports = [
    {
      'name': 'Krit Tacho',
      'title': 'Water type: Canal',
      'description':
          'The canal water is black and smells bad, possibly due to sewage discharge.',
      'date': 'May 26, 2025',
      'status': 'Pending',
      'mapImage': 'assets/image/Maps.png',
    },
    {
      'name': 'Krit Tacho',
      'title': 'Title: Smelly water issue reported',
      'description':
          'The water in this area smells unpleasant and appears polluted. Please investigate the source.',
      'date': 'May 26, 2025',
      'status': 'Pending',
      'mapImage': 'assets/image/Maps.png',
    },
    {
      'name': 'Krit Tacho',
      'title': 'Title: Smelly water issue reported',
      'description':
          'The water in this area smells unpleasant and appears polluted. Please investigate the source.',
      'date': 'May 26, 2025',
      'status': 'Pending',
      'mapImage': 'assets/image/Maps.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.orange),
          const SizedBox(width: 4),
          Text(status, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFD9EBFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              report['mapImage'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: _buildStatusChip(report['status']),
                ),
                Text(
                  report['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  report['title'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text('"${report['description']}"'),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Updated: ${report['date']}',
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Image.asset(
                  'assets/image/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Reports',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'In Progress'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: reports.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder:
                        (context, index) => _buildReportCard(reports[index]),
                  ),
                  Center(child: Text('In Progress reports will be here.')),
                  Center(child: Text('Completed reports will be here.')),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/adminHome');
          if (index == 1) Navigator.pushNamed(context, '/adminReport');
          if (index == 2) Navigator.pushNamed(context, '/adminProfile');
        },
      ),
    );
  }
}
