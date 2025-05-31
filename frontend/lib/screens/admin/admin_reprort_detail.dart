import 'package:flutter/material.dart';

class AdminReportDetailScreen extends StatelessWidget {
  final String status; // 'Pending', 'In Progress', or 'Completed'

  const AdminReportDetailScreen({Key? key, required this.status})
    : super(key: key);

  Color _getStatusColor() {
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

  String _getActionText() {
    switch (status) {
      case 'Pending':
        return 'Confirm';
      case 'In Progress':
        return 'Done';
      case 'Completed':
        return 'Close';
      default:
        return 'Action';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with banner
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

          // Back & title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Report Detail',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    '• $status',
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Map
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/image/Maps.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'King Mongkut\'s University of Technology Thonburi,\nBang Mot, Thung Khru District, Bangkok 10140',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),

          const Divider(thickness: 1, height: 20),

          // Report details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Krit  Tacho',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('23 May 2025'),
                  ],
                ),
                SizedBox(height: 4),
                Text('DD/MM/YYYY'),
                SizedBox(height: 8),
                Text('E-mail', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('namsaijaew@gmail.com'),
                SizedBox(height: 8),
                Text('Tel.', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('+66 98 7654321'),
                SizedBox(height: 16),
                Text('Problem', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  'Water Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Canal'),
                SizedBox(height: 8),
                Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'The canal water is black and smells bad, possibly due to sewage discharge.\nTrash and waste are floating on the surface.',
                ),
              ],
            ),
          ),

          const Spacer(),

          // Action buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(''),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      _getActionText(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7CB8E2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
