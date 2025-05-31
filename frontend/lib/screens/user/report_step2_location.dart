import 'package:flutter/material.dart';
import 'package:frontend/widgets/user/report_step_progress_bar.dart';

class ReportStep2Location extends StatefulWidget {
  final String waterType;
  final String details;

  const ReportStep2Location({
    Key? key,
    required this.waterType,
    required this.details,
  }) : super(key: key);

  @override
  _ReportStep2LocationState createState() => _ReportStep2LocationState();
}

class _ReportStep2LocationState extends State<ReportStep2Location> {
  final TextEditingController addressController = TextEditingController(
    text: 'King Mongkut\'s University of Technology Thonburi',
  );
  final TextEditingController districtController = TextEditingController(
    text: 'Thung Khru',
  );
  final TextEditingController provinceController = TextEditingController(
    text: 'Bangkok',
  );
  final TextEditingController zipcodeController = TextEditingController(
    text: '10140',
  );
  final TextEditingController telController = TextEditingController(
    text: '0987654321',
  );

  void _submitReport() {
    Navigator.pushNamed(
      context,
      '/reportStep3',
      arguments: {
        'waterType': widget.waterType,
        'details': widget.details,
        'address': addressController.text,
        'district': districtController.text,
        'province': provinceController.text,
        'zipcode': zipcodeController.text,
        'tel': telController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top banner
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

            // Back button + title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
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
              currentStep: 2,
              stepLabels: ['Water Type', 'Location', 'Report Submitted'],
            ),

            // Form content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Pin or Enter Location',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/image/Maps.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: districtController,
                          decoration: const InputDecoration(
                            labelText: 'District',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: provinceController,
                          decoration: const InputDecoration(
                            labelText: 'Province',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: zipcodeController,
                          decoration: const InputDecoration(
                            labelText: 'Zipcode',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: telController,
                          decoration: const InputDecoration(
                            labelText: 'Tel.',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: _submitReport,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: const Color(0xFF7CB8E2),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 18)),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
