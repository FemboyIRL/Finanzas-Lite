import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/overlays/budget_menu_overlay/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetsMenuOverlay extends StatelessWidget {
  final BudgetViewModel budget;
  const BudgetsMenuOverlay({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BudgetMenuState>(
      init: BudgetMenuState(),
      builder: (state) => FullScreenOverlay(
        title: "Ajustes ${budget.name}",
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Text("Editar Presupuesto"),
                ),
              ),
              GestureDetector(
                onTap: () => state.onDeleteBudget(budget.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Text(
                    "Eliminar Presupuesto",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
