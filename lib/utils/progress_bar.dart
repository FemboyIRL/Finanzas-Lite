import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double limit;
  final double spent;
  final Color color;

  const ProgressBar({
    super.key,
    required this.limit,
    required this.spent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // rawProgress = valor real (puede ser > 1)
    final double rawProgress = limit > 0
        ? (spent / limit)
        : (spent > 0 ? double.infinity : 0.0);

    // progressForBar = valor entre 0 y 1
    final double progressForBar = rawProgress.isFinite
        ? rawProgress.clamp(0.0, 1.0)
        : 1.0;

    final bool excedido = limit > 0 ? spent > limit : spent > 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double filledWidth = progressForBar * maxWidth;

        return Stack(
          children: [
            // Fondo de la barra
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(5),
              ),
            ),

            // Barra llenada
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 8,
              width: filledWidth,
              decoration: BoxDecoration(
                color: excedido ? Colors.red : color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),

            // Línea roja si excede el límite
            if (rawProgress > 1 && maxWidth > 0)
              Positioned(
                left: maxWidth - 1,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 2,
                  color: Colors.redAccent.withOpacity(0.8),
                ),
              ),
          ],
        );
      },
    );
  }
}
