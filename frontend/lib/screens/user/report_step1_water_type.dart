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
    // รายการประเภทน้ำ
    final waterTypes = ['Canal', 'River', 'Lake', 'Pond', 'Drain', 'Other:'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── 1) Banner (สูง 160) ───────────────────────────────────────
          SizedBox(
            height:
                160, // ใช้ขนาดเดียวกับหน้าก่อนหน้า เพื่อให้ตำแหน่งข้อความสอดคล้องกัน
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Image.asset('assets/image/banner.png', fit: BoxFit.cover),
            ),
          ),

          // ── 2) วางข้อความ "New Report" ทับบน Banner ─────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Row(
                children: const [
                  Text(
                    'New Report',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      shadows: [Shadow(color: Colors.white70, blurRadius: 2)],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── 3) เนื้อหา (ProgressBar + ฟอร์ม) ────────────────────────────
          //      เริ่มจากขอบบนเท่ากับ ความสูง Banner (160) + SafeArea vertical padding (16)
          Padding(
            // top: 160 + 16 + ปรับช่องว่างเพิ่มเติม (4) = 180
            padding: const EdgeInsets.only(
              top: 180,
              left: 20,
              right: 20,
              bottom: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Progress Bar ────────────────────────────────────────────
                const ReportStepProgressBar(
                  currentStep: 1,
                  stepLabels: ['Water Type', 'Location', 'Report Submitted'],
                ),

                const SizedBox(height: 24),

                // ── แบบฟอร์มเลือกประเภทน้ำ ───────────────────────────────────
                const Text(
                  'Select Water Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // RadioListTile แต่ละประเภทน้ำ พร้อมเปลี่ยนสีวงกลมเมื่อถูกเลือก
                ...waterTypes.map((type) {
                  return RadioListTile<String>(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    dense: true,
                    title: Text(
                      type,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    value: type,
                    groupValue: selectedWaterType,
                    activeColor: const Color(0xFF7CB8E2),
                    // activeColor จะกำหนดสีวงกลม (dot + outline) เมื่อถูกเลือก
                    onChanged: (val) => setState(() => selectedWaterType = val),
                  );
                }).toList(),

                if (selectedWaterType == 'Other:') ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: customWaterTypeController,
                    style: const TextStyle(
                      color: Color(
                        0xFF7CB8E2,
                      ), // ข้อความที่พิมพ์จะเป็นสีฟ้าเมื่อเลือก
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter custom water type',
                      labelStyle: const TextStyle(color: Color(0xFF7CB8E2)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF7CB8E2),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF7CB8E2),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF7CB8E2),
                          width: 2,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                const SizedBox(height: 24),

                // ── กล่องกรอกรายละเอียด ───────────────────────────────────────
                const Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F5FF),
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

                const Spacer(), // ดึงปุ่มไปชิดล่าง เพื่อเว้นระยะจากเนื้อหาให้สวยงาม
              ],
            ),
          ),

          // ── 4) ปุ่ม Next (Gradient Circular Button) ──────────────────────
          Positioned(
            bottom: 30,
            right: 24,
            child: GestureDetector(
              onTap: _goToStep2,
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF59A5D8),
                      Color(0xFF91C7EB),
                      Color(0xFFCAE9FF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
