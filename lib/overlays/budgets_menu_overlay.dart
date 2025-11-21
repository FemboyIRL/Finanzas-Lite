import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:flutter/material.dart';

class BudgetsMenuOverlay extends StatelessWidget {
  final BudgetViewModel budget;
  const BudgetsMenuOverlay({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return FullScreenOverlay(
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
              // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => )),
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
    );
  }
}
