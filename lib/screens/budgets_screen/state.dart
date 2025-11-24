import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/overlays/budgets_menu_overlay.dart';
import 'package:finanzas_lite/overlays/create_budget/overlay.dart';
import 'package:finanzas_lite/screens/budgets_screen/resources.dart';
import 'package:flutter/material.dart';

class BudgetsState extends BudgetsResources {
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
