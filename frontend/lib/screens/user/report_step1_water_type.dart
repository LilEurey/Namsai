import 'package:flutter/material.dart';
import 'package:frontend/widgets/user/report_step_progress_bar.dart';

class ReportStep1WaterType extends StatefulWidget {
  const ReportStep1WaterType({Key? key}) : super(key: key);

  @override
  _ReportStep1WaterTypeState createState() => _ReportStep1WaterTypeState();
}

class _ReportStep1WaterTypeState extends State<ReportStep1WaterType> {
  String? selectedWaterType;
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController customWaterTypeController =
      TextEditingController();

  void _goToStep2() {
    final trimmedWaterType = selectedWaterType?.trim() ?? '';
    final trimmedDetails = detailsController.text.trim();
    final customWaterType = customWaterTypeController.text.trim();

    if (trimmedWaterType.isEmpty || trimmedDetails.isEmpty) {
      _showError('Please select a water type and enter details');
      return;
    }

    if (trimmedWaterType == 'Other' && customWaterType.isEmpty) {
      _showError('Please specify your custom water type');
      return;
    }

    Navigator.pushNamed(
      context,
      '/reportStep2',
      arguments: {
        'waterType': trimmedWaterType,
        'details': trimmedDetails,
        'customWaterType': trimmedWaterType == 'Other' ? customWaterType : '',
      },
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final waterTypes = ['Canal', 'River', 'Lake', 'Pond', 'Drain', 'Other'];

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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const ReportStepProgressBar(
              currentStep: 1,
              stepLabels: ['Water Type', 'Location', 'Report Submitted'],
            ),

            // Form
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView(
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'Select Water Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...waterTypes.map((type) {
                      return RadioListTile<String>(
                        title: Text(type),
                        value: type,
                        groupValue: selectedWaterType,
                        onChanged:
                            (val) => setState(() => selectedWaterType = val),
                      );
                    }).toList(),

                    if (selectedWaterType == 'Other') ...[
                      const SizedBox(height: 6),
                      TextField(
                        controller: customWaterTypeController,
                        decoration: const InputDecoration(
                          labelText: 'Enter custom water type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),
                    const Text(
                      'Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9EBFF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: detailsController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tell us more...',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _goToStep2,
                  backgroundColor: const Color(0xFF7CB8E2),
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
