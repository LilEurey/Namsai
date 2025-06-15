import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  static const String baseUrl = 'https://badeesorn.pawarisa.com/intproj/app4api/api/reports';

  /// Create new report
  static Future<Map<String, dynamic>> createReport({
    required String waterType,
    required String detail,
    required String locationDescription,
    required Map<String, dynamic> coordinates,
    required String createdBy,
    required String customWaterType,
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

  static Future<List<Map<String, dynamic>>> fetchReports() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));

      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<void> updateReportStatus(
    String reportId,
    String newStatus,
  ) async {
    final url = Uri.parse('https://badeesorn.pawarisa.com/intproj/app4api/api/reports/$reportId/status');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update report status');
    }
  }

  static Future<void> deleteReport(String reportId) async {
    final url = Uri.parse('https://badeesorn.pawarisa.com/intproj/app4api/api/reports/$reportId');

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete report');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchUserNotifications(
    String userId,
  ) async {
    final url = Uri.parse('https://badeesorn.pawarisa.com/intproj/app4api/api/notifications/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }
}
