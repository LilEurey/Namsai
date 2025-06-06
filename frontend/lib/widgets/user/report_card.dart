import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ReportCard extends StatelessWidget {
  final String name;
  final String water_type;
  final String detail;
  final String status;
  final String updatedAt;
  final List<double> coordinates; // [longitude, latitude]

  const ReportCard({
    super.key,
    required this.name,
    required this.water_type,
    required this.detail,
    required this.status,
    required this.updatedAt,
    required this.coordinates,
  });

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'in progress':
        return Colors.lightBlue;
      case 'pending':
        return Colors.amber;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat = coordinates[1];
    final lng = coordinates[0];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌍 Flutter Map Preview (OpenStreetMap)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 120, // ลดจาก 120 เป็น 100
              width: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(lat, lng),
                  zoom: 15,
                  interactiveFlags:
                      InteractiveFlag.none, // Disable user interactions
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40,
                        height: 40,
                        point: LatLng(lat, lng),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            "Title: $water_type",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 40, // ลดจาก 50 เป็น 40
            child: SingleChildScrollView(
              child: Text(detail, style: const TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Updated: $updatedAt",
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
