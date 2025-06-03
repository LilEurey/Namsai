import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class GeoService {
  static Future<LatLng?> getCoordinatesFromAddress(String address) async {
    final encodedAddress = Uri.encodeFull(address);
    final url =
        'https://nominatim.openstreetmap.org/search?q=$encodedAddress&format=json&limit=1';

    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': 'Flutter App'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data.isNotEmpty) {
        final lat = double.tryParse(data[0]['lat']);
        final lon = double.tryParse(data[0]['lon']);
        if (lat != null && lon != null) return LatLng(lat, lon);
      }
    }

    return null;
  }
}