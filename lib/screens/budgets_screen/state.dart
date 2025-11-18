import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class BudgetsState extends GetxController {
  final budgets = <BudgetViewModel>[
    BudgetViewModel(
      id: '1',
      color: Color(0xFFFFD466),
      name: "Comida",
      currentAmountSpent: 3430,
      limit: 5000,
      transactions: [],
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFF66FFA3),
      name: "Transporte",
      currentAmountSpent: 4300,
      limit: 800,
      transactions: [],
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFF3DB9FF),
      name: "Salud",
      currentAmountSpent: 3000,
      limit: 5000.25,
      transactions: [],
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFFFFD466),
      name: "Vida Diaría DEL PEPE Y ETE SECH",
      currentAmountSpent: 2500,
      limit: 5000,
      transactions: [],
    ),
  ];

  void onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
