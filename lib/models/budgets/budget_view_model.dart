import 'dart:ui';

import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:finanzas_lite/utils/color_helper.dart';

class BudgetViewModel {
  final String id;
  final String userId;
  final Color color;
  final String name;
  final double limit;
  final double currentAmountSpent;
  final List<TransactionViewModel> transactions;

  const BudgetViewModel({
    required this.id,
    required this.userId,
    required this.color,
    required this.name,
    required this.currentAmountSpent,
    required this.limit,
    required this.transactions,
  });

  // ======================
  //       FROM JSON
  // ======================
  factory BudgetViewModel.fromJson(Map<String, dynamic> json) {
    return BudgetViewModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      color: ColorHelper.colorFromHex(json['color_hex']),
      limit: double.parse(json['limit_amount'].toString()),
      currentAmountSpent: double.parse(json['current_amount_spent'].toString()),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionViewModel.fromJson(e))
          .toList(),
    );
  }

  // ======================
  //         TO JSON
  // ======================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color_hex': ColorHelper.colorToHex(color),
      'limit_amount': limit,
      'current_amount_spent': currentAmountSpent,
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }
}
