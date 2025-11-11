import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/utils/circular_budget_chart.dart';
import 'package:flutter/material.dart';

class BudgetInfoCard extends StatelessWidget {
  final BudgetViewModel budget;

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
            painter: CircularBudgetPainter(
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
