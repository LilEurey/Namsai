import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  static const String baseUrl = 'http://localhost:3000/api/reports';

  // Fetch reports for the currently logged-in user
  static Future<List<Map<String, dynamic>>> getUserReports(String token) async {
    final url = Uri.parse('$baseUrl/myreports');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // ✅ Token from login
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      print('❌ Failed to fetch reports: ${response.statusCode}');
      throw Exception('Failed to load reports');
    }
  }

  // ✅ Create a new report
  static Future<Map<String, dynamic>> createReport({
    required String waterType,
    required String detail,
    required String locationDescription,
    required Map<String, dynamic> coordinates,
    required String createdBy,
  }) async {
    final url = Uri.parse(baseUrl); // http://localhost:3000/api/reports

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "water_type": waterType,
        "detail": detail,
        "location_description": locationDescription,
        "coordinates": coordinates,
        "createdBy": createdBy,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)['error']);
    }
  }

  // Add other endpoints here if needed (createReport, updateReport, etc.)
}
