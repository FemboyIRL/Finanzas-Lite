import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/overlays/budget_menu_overlay/budgets_menu_overlay.dart';
import 'package:finanzas_lite/overlays/create_budget/overlay.dart';
import 'package:finanzas_lite/screens/budgets_screen/resources.dart';
import 'package:flutter/material.dart';

class BudgetsState extends BudgetsResources {
  @override
  void onInit() async {
    super.onInit();
    await supabase.init();
    await fetchData();
    balance = budgets.fold(0, (sum, b) => sum + b.limit);
    totalSpent = budgets.fold(0, (sum, b) => sum + b.currentAmountSpent);
    totalRemaining = balance - totalSpent;
    total = categories.fold(0, (sum, c) => sum + c.currentAmountSpent);
    percentSpent = balance > 0 ? (totalSpent / balance) * 100 : 0;
    update();
  }

  Future<void> fetchData() async {
    budgets.addAll(await supabase.fetchBudgets());
    categories.addAll(await supabase.fetchCategories());
    accounts.addAll(await supabase.fetchAccounts());
  }

  void onTapNewBudget(BuildContext context) {
    Navigator.of(context).pushReplacement(
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
}
