import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularBudgetPainter extends CustomPainter {
  final Color color;
  final double progress;

  CircularBudgetPainter({required this.color, required this.progress});

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
