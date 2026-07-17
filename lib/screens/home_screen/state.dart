import 'package:finanzas_lite/screens/budgets_screen/screen.dart';
import 'package:finanzas_lite/screens/home_screen/resources.dart';
import 'package:finanzas_lite/screens/records_screen/screen.dart';
import 'package:finanzas_lite/screens/stats_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomeState extends HomeResources {
  @override
  void onInit() async {
    super.onInit();
    await supabase.init();

    budgets.addAll(await supabase.fetchBudgets());
    accounts.assignAll(await supabase.fetchAccounts());
    transactions.addAll(await supabase.fetchTransactions());
    categories.addAll(await supabase.fetchCategories());

    balance = budgets.fold(0, (sum, b) => sum + b.limit);

    total = accounts.fold(0, (sum, acc) => sum + acc.currentAmount);

    totalSpent = budgets.fold(0, (sum, b) => sum + b.currentAmountSpent);

    categoriesTotal = categories.fold(
      0,
      (sum, c) => sum + c.currentAmountSpent,
    );

    totalRemaining = balance - totalSpent;
    update();
  }

  void onTapAllTransactions(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const RecordsScreen()));
  }

  void onTapAllBudgets(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BudgetsScreen()));
  }

  void onTapAllStats(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const StatisticsScreen()));
  }
}
