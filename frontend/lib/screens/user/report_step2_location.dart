import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:frontend/widgets/user/report_step_progress_bar.dart';
import 'package:frontend/services/geo_service.dart';

class ReportStep2Location extends StatefulWidget {
  const ReportStep2Location({
    super.key,
    required String waterType,
    required String details,
    required String customWaterType,
  });

  @override
  State<ReportStep2Location> createState() => _ReportStep2LocationState();
}

class _ReportStep2LocationState extends State<ReportStep2Location> {
  late String waterType;
  late String details;
  late String customWaterType;

  LatLng? currentLocation;
  final TextEditingController addressController = TextEditingController();
  final MapController mapController = MapController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _showError('Missing data from previous step'),
      );
      Navigator.pop(context);
      return;
    }
    waterType = args['waterType'] ?? '';
    details = args['details'] ?? '';
    customWaterType = args['customWaterType'] ?? '';
  }

  Future<void> _searchAddress() async {
    final rawInput = addressController.text.trim();
    if (rawInput.isEmpty) {
      _showError('Please enter an address.');
      return;
    }
    final fullQuery =
        rawInput.contains('Thailand')
            ? rawInput
            : '$rawInput, Bangkok, Thailand';
    final coordinates = await GeoService.getCoordinatesFromAddress(fullQuery);
    if (coordinates == null) {
      _showError('❌ Failed to find coordinates.');
      return;
    }
    setState(() => currentLocation = coordinates);
    mapController.move(coordinates, 16);
  }

  Future<void> _submitReport() async {
    if (currentLocation == null || addressController.text.isEmpty) {
      _showError('Please enter a valid address.');
      return;
    }
    final userId = await AuthService.getUserId();
    if (userId == null || userId.length != 24) {
      _showError('User ID not found or invalid.');
      return;
    }
    Navigator.pushNamed(
      context,
      '/reportStep3',
      arguments: {
        'waterType': waterType,
        'details': details,
        'customWaterType': customWaterType,
        'location_description': addressController.text,
        'coordinates': {
          'type': 'Point',
          'coordinates': [
            currentLocation!.longitude,
            currentLocation!.latitude,
          ],
        },
        'createdBy': userId,
      },
    );
  }

  void _showError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'New Report',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const ReportStepProgressBar(
              currentStep: 2,
              stepLabels: ['Water Type', 'Location', 'Report Submitted'],
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE3F2FD),
                        hintText: 'e.g., Central Rama 2',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _searchAddress,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: const Color(0xFF7CB8E2),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 160,
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: currentLocation ?? LatLng(13.6517, 100.4964),
                      zoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        tileProvider: CancellableNetworkTileProvider(),
                      ),
                      if (currentLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: currentLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_pin,
                                size: 40,
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7CB8E2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // กำหนดสีตัวอักษรเป็นขาว
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
