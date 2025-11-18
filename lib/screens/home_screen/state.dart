import 'package:finanzas_lite/screens/budgets_screen/screen.dart';
import 'package:finanzas_lite/screens/home_screen/resources.dart';
import 'package:finanzas_lite/screens/records_screen/screen.dart';
import 'package:finanzas_lite/screens/stats_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeState extends HomeResources {
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
