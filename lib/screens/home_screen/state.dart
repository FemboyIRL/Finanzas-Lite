import 'package:finanzas_lite/screens/budgets_screen/screen.dart';
import 'package:finanzas_lite/screens/home_screen/resources.dart';
import 'package:finanzas_lite/screens/records_screen/screen.dart';
import 'package:finanzas_lite/screens/stats_screen/screen.dart';
import 'package:flutter/material.dart';

class HomeState extends HomeResources {
  @override
  void onInit() async {
    super.onInit();
    await supabase.init();

    budgets.addAll(await supabase.fetchBudgets());
    transactions.addAll(await supabase.fetchTransactions());
    categories.addAll(await supabase.fetchCategories());
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
