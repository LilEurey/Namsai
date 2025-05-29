import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String name;
  final String title;
  final String description;
  final String status;
  final String date;
  final String mapImage;

  const ReportCard({
    super.key,
    required this.name,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.mapImage,
  });

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'in progress':
        return Colors.lightBlue;
      case 'pending':
        return Colors.amber;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              mapImage,
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
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("Title: $title", style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                // Scrollable description container with max height
                SizedBox(
                  height: 50, // Adjust height as needed
                  child: SingleChildScrollView(
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Updated: $date",
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
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
    );
  }
}
