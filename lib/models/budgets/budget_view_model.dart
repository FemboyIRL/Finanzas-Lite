import 'dart:ui';

import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';

class BudgetViewModel {
  final String id;
  final Color color;
  final String name;
  final double limit;
  final double currentAmountSpent;
  final List<TransactionViewModel>? transactions;

  const BudgetViewModel({
    required this.id,
    required this.color,
    required this.name,
    required this.currentAmountSpent,
    required this.limit,
    this.transactions,
  });
}
