import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/overlays/budgets_menu_overlay.dart';
import 'package:finanzas_lite/overlays/create_budget/overlay.dart';
import 'package:flutter/material.dart';
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

  final accounts = <AccountViewModel>[].obs;
  final categories = <CategoryViewModel>[];

  void onTapNewBudget(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CreateBudgetOverlay(categories: categories, accounts: accounts),
      ),
    );
  }

  void onTapOpenMenu(BuildContext context, BudgetViewModel budget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BudgetsMenuOverlay(budget: budget),
      ),
    );
  }

  void onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
