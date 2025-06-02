import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  static const String baseUrl = 'http://localhost:3000/api/reports';

  /// Create new report
  static Future<Map<String, dynamic>> createReport({
    required String waterType,
    required String detail,
    required String locationDescription,
    required Map<String, dynamic> coordinates,
    required String createdBy, required String customWaterType,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'water_type': waterType,
        'detail': detail,
        'location_description': locationDescription,
        'coordinates': coordinates,
        'createdBy': createdBy,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Failed to create report');
    }
  }

  /// Get reports created by the logged-in user
  static Future<List<Map<String, dynamic>>> getUserReports(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/myreports'), // 👉 /api/reports/myreports
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['reports'] is List) {
        return List<Map<String, dynamic>>.from(decoded['reports']);
      } else {
        throw Exception("Invalid format: 'reports' is not a List");
      }
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Failed to load reports');
    }
  }
}
