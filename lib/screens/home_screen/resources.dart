import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:get/get.dart';

class HomeResources extends GetxController {
  final supabase = SupabaseHelper();

  final budgets = <BudgetViewModel>[];

  final categories = <CategoryViewModel>[];

  final accounts = <AccountViewModel>[];

  final transactions = <TransactionViewModel>[];

  // Calcular total gastado por todas las cate

  late double balance = budgets.fold(0, (sum, b) => sum + b.limit);

  late double totalSpent = budgets.fold(
    0,
    (sum, b) => sum + b.currentAmountSpent,
  );

  late double totalRemaining = totalSpent - balance;

  late double total = categories.fold(
    0,
    (sum, c) => sum + c.currentAmountSpent,
  );
}
