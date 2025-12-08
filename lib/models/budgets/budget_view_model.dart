import 'dart:ui';

import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';

class BudgetViewModel {
  final String id;
  final String userId;
  final Color color;
  final String month;
  final String name;
  final double limit;
  double currentAmountSpent;
  final List<CategoryViewModel> categories;
  final List<AccountViewModel> accounts;
  List<TransactionViewModel> transactions;

  BudgetViewModel({
    required this.id,
    required this.userId,
    required this.color,
    required this.name,
    required this.month,
    required this.currentAmountSpent,
    required this.limit,
    required this.transactions,
    required this.categories,
    required this.accounts,
  });

  factory BudgetViewModel.fromJson(Map<String, dynamic> json) {
    final categories = (json['budget_categories'] as List<dynamic>)
        .map((e) => CategoryViewModel.fromJson(e["categories"]))
        .toList();

    final accounts = (json['budget_accounts'] as List<dynamic>)
        .map((e) => AccountViewModel.fromJson(e["accounts"]))
        .toList();

    return BudgetViewModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      month: json['month'] as String,
      color: Color(int.parse(json['color_hex'])),
      limit: double.parse(json['limit_amount'].toString()),
      categories: categories,
      accounts: accounts,
      transactions: [], // se llena después
      currentAmountSpent: 0.0, // se recalcula después
    );
  }

  void recalculateAmountSpent() {
    currentAmountSpent = transactions.fold(0.0, (sum, t) => sum + t.amount);
  }
}
