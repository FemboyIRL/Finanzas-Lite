import 'dart:math' as math;

import 'package:finanzas_lite/screens/home_screen/resources.dart';
import 'package:flutter/material.dart';

class BudgetInfoCard extends StatelessWidget {
  final Budget budget;

  const BudgetInfoCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el progreso
    final double progress = (budget.currentAmountSpent / budget.limit).clamp(
      0.0,
      1.0,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: budget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomPaint(
            size: const Size(36, 36),
            painter: _CircularBudgetPainter(
              color: budget.color,
              progress: progress,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  budget.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "\$${budget.currentAmountSpent}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: budget.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularBudgetPainter extends CustomPainter {
  final Color color;
  final double progress;

  _CircularBudgetPainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final rect = Offset.zero & size;
    final Paint basePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Dibuja el fondo
    canvas.drawArc(rect.deflate(4), 0, 2 * math.pi, false, basePaint);

    // Dibuja el progreso
    canvas.drawArc(
      rect.deflate(4),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
