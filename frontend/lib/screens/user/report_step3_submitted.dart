import 'package:flutter/material.dart';
import 'package:frontend/services/report_services.dart';
import 'package:frontend/widgets/user/report_step_progress_bar.dart';

class ReportStep3Submitted extends StatefulWidget {
  const ReportStep3Submitted({super.key, required Map reportData});

  @override
  State<ReportStep3Submitted> createState() => _ReportStep3SubmittedState();
}

class _ReportStep3SubmittedState extends State<ReportStep3Submitted> {
  Map<String, dynamic>? reportData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) _submitReport(args);
  }

  Future<void> _submitReport(Map<String, dynamic> args) async {
    try {
      final response = await ReportService.createReport(
        waterType: args['waterType'],
        detail: args['details'],
        locationDescription: args['location_description'],
        coordinates: args['coordinates'],
        createdBy: 'user12345', // Replace with actual user ID
      );

      setState(() {
        reportData = {
          'waterType': response['report']['water_type'],
          'details': response['report']['detail'],
          'address': response['report']['location_description'],
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = '❌ Failed to submit report: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : _buildSuccessContent(),
      ),
    );
  }

  Widget _buildSuccessContent() {
    final String waterType = reportData!['waterType'];
    final String details = reportData!['details'];
    final String address = reportData!['address'];

    return Column(
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
          currentStep: 3,
          stepLabels: ['Water Type', 'Location', 'Report Submitted'],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _buildSummaryCard(waterType, details, address),
                const Spacer(),
                ElevatedButton(
                  onPressed:
                      () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
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
    );
  }

  Widget _buildSummaryCard(String waterType, String details, String address) {
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
            Text(address),
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
