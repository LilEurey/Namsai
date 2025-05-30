import 'package:flutter/material.dart';

class ReportStepProgressBar extends StatelessWidget {
  final int currentStep;
  final List<String> stepLabels;

  const ReportStepProgressBar({
    Key? key,
    required this.currentStep,
    required this.stepLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _StepLinePainter(
                      stepCount: stepLabels.length,
                      currentStep: currentStep,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(stepLabels.length, (index) {
                    int step = index + 1;
                    return _buildStepCircle(step);
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(stepLabels.length, (index) {
              return SizedBox(
                width: 60,
                child: Text(
                  _formatLabel(stepLabels[index]),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _formatLabel(String label) {
    if (label.toLowerCase() == 'location') return 'Location';
    if (label.toLowerCase() == 'report submitted') return 'Report\nSubmitted';
    return label;
  }

  Widget _buildStepCircle(int step) {
    bool isActive = step == currentStep;
    bool isCompleted = step < currentStep;

    Color fillColor =
        isActive
            ? const Color(0xFF5DA5D9)
            : isCompleted
            ? const Color(0xFFB3D9F5)
            : Colors.grey.shade300;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: fillColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        '$step',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _StepLinePainter extends CustomPainter {
  final int stepCount;
  final int currentStep;

  _StepLinePainter({required this.stepCount, required this.currentStep});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint inactivePaint =
        Paint()
          ..strokeWidth = 4
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke;

    final Paint activePaint =
        Paint()
          ..strokeWidth = 4
          ..color = const Color(0xFF5DA5D9)
          ..style = PaintingStyle.stroke;

    final double totalWidth = size.width;
    final double spacing = totalWidth / (stepCount - 1);
    final double circleRadius = 18; // half of circle size (36)
    final double y = size.height / 2;

    for (int i = 0; i < stepCount - 1; i++) {
      final double startX = i * spacing + circleRadius;
      final double endX = (i + 1) * spacing - circleRadius;

      canvas.drawLine(
        Offset(startX, y),
        Offset(endX, y),
        (i + 1 < currentStep) ? activePaint : inactivePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
