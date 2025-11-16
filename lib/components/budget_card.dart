import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/screens/budget_details_screen/screen.dart';
import 'package:finanzas_lite/utils/progress_bar.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final BudgetViewModel budget;

  const BudgetCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    // rawProgress = valor real (puede ser > 1)
    final double rawProgress = (budget.limit > 0)
        ? (budget.currentAmountSpent / budget.limit)
        : (budget.currentAmountSpent > 0 ? double.infinity : 0.0);

    // progressForBar se usa para el ancho de la barra (entre 0 y 1)
    final double progressForBar = rawProgress.isFinite
        ? rawProgress.clamp(0.0, 1.0)
        : 1.0;

    final bool excedido = budget.limit > 0
        ? budget.currentAmountSpent > budget.limit
        : budget.currentAmountSpent > 0;
    final double diferencia = budget.currentAmountSpent - budget.limit;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BudgetDetailsScreen(budget: budget),
        ),
      ),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              children: [
                // Título
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        budget.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: budget.color, fontSize: 25),
                      ),
                    ),
                    const Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),

                const SizedBox(height: 8),

                // Monto actual y porcentaje real (puede ser >100%)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${budget.limit.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      "${(rawProgress * 100).isFinite ? (rawProgress * 100).toStringAsFixed(0) : '∞'}%",
                    ),
                  ],
                ),

                // Barra de progreso (usa LayoutBuilder para ancho dinámico)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: ProgressBar(
                    limit: budget.limit,
                    spent: budget.currentAmountSpent,
                    color: budget.color,
                  ),
                ),

                // Textos de gasto y disponible/excedido
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "-\$${budget.currentAmountSpent.toStringAsFixed(2)} gastado",
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      excedido
                          ? "\$${diferencia.abs().toStringAsFixed(2)} sobre el límite"
                          : "\$${(budget.limit - budget.currentAmountSpent).abs().toStringAsFixed(2)} disponible",
                      style: TextStyle(
                        fontSize: 13,
                        color: excedido ? Colors.red : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
