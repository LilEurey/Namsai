import 'package:flutter/material.dart';
import 'package:frontend/widgets/user/report_step_progress_bar.dart';

class ReportStep3Submitted extends StatelessWidget {
  final Map<String, dynamic> reportData;

  const ReportStep3Submitted({Key? key, required this.reportData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final waterType = reportData['waterType'] ?? '';
    final details = reportData['details'] ?? '';
    final address = reportData['address'] ?? '';
    final district = reportData['district'] ?? '';
    final province = reportData['province'] ?? '';
    final zipcode = reportData['zipcode'] ?? '';
    final tel = reportData['tel'] ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'New Report',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const ReportStepProgressBar(
              currentStep: 3,
              stepLabels: ['Water Type', 'Location', 'Report Submitted'],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.lightGreen,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your report has been submitted.\nThanks for your report!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildSummaryCard(
                          waterType,
                          details,
                          address,
                          district,
                          province,
                          zipcode,
                          tel,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed:
                          () => Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7CB8E2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Done', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String waterType,
    String details,
    String address,
    String district,
    String province,
    String zipcode,
    String tel,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFD9EBFF),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Water Type :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(waterType),
            const SizedBox(height: 8),
            const Text(
              'Details :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(details),
            const SizedBox(height: 12),
            const Text(
              'Address :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('$address, $district District, $province $zipcode'),
            const SizedBox(height: 12),
            Text('Tel: $tel'),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/image/Maps.png',
                fit: BoxFit.cover,
                height: 140,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
