import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/services/report_services.dart';
import 'package:latlong2/latlong.dart';

class AdminReportDetailScreen extends StatelessWidget {
  const AdminReportDetailScreen({Key? key, required String status})
    : super(key: key);

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

  String _getActionText(String status) {
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
    final Map<String, dynamic> report =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final status = report['status'] ?? 'Pending';
    final name = report['createdBy']?['name'] ?? 'Unknown';
    final email = report['createdBy']?['email'] ?? '-';
    final tel = report['createdBy']?['tel'] ?? '-';
    final date = (report['updatedAt'] ?? '').toString().split('T')[0];
    final waterType = report['water_type'] ?? '-';
    final detail = report['detail'] ?? '-';
    final coords = report['coordinates']?['coordinates'] ?? [100.494, 13.652];
    final lng = double.tryParse(coords[0].toString()) ?? 100.494;
    final lat = double.tryParse(coords[1].toString()) ?? 13.652;

    final statusColor = _getStatusColor(status);
    final actionText = _getActionText(status);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(lat, lng),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(lat, lng),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              report['location_description'] ?? 'No location provided',
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(thickness: 1, height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'DD/MM/YYYY',
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ),
                    Expanded(flex: 3, child: Text(date)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'E-mail',
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ),
                    Expanded(flex: 3, child: Text(email)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Tel.',
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ),
                    Expanded(flex: 3, child: Text(tel)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Problem',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Water Type',
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ),
                    Expanded(flex: 3, child: Text(waterType)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Details',
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ),
                    Expanded(flex: 3, child: Text(detail)),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Text(
                              'Delete form?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm == true) {
                        try {
                          await ReportService.deleteReport(report['_id']);
                          if (context.mounted) {
                            Navigator.pop(context, true); // Trigger refresh
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Report deleted successfully'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error deleting report: $e'),
                            ),
                          );
                        }
                      }
                    },
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
                    onPressed: () async {
                      try {
                        String newStatus =
                            status == 'Pending'
                                ? 'In Progress'
                                : status == 'In Progress'
                                ? 'Completed'
                                : status; // Don't update if status is already Completed

                        if (status == 'Completed') {
                          Navigator.pop(context);
                          return;
                        } // No change needed

                        await ReportService.updateReportStatus(
                          report['_id'],
                          newStatus,
                        );

                        if (context.mounted) {
                          Navigator.pop(
                            context,
                            true,
                          ); // Refresh the list on return
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Status updated to $newStatus'),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7CB8E2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      actionText,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
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
