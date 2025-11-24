import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:get/get.dart';

class BudgetsResources extends GetxController {
  final budgets = <BudgetViewModel>[];
  final accounts = <AccountViewModel>[].obs;
  final categories = <CategoryViewModel>[];

  late double balance = budgets.fold(0, (sum, b) => sum + b.limit);

  late double totalSpent = budgets.fold(
    0,
    (sum, b) => sum + b.currentAmountSpent,
  );

  late double totalRemaining = balance - totalSpent;

  late double total = categories.fold(
    0,
    (sum, c) => sum + c.currentAmountSpent,
  );

  late double percentSpent = balance > 0 ? (totalSpent / balance) * 100 : 0;
}
