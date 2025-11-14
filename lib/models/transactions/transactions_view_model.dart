import 'package:flutter/material.dart';

enum TransactionType { zero, expense, income, transfer }

extension TransactionTypeExtension on TransactionType {
  String get name {
    switch (this) {
      case TransactionType.zero:
        return "";
      case TransactionType.expense:
        return "Gasto";
      case TransactionType.income:
        return "Ingreso";
      case TransactionType.transfer:
        return "Transferencia";
    }
  }

  Color get color {
    switch (this) {
      case TransactionType.zero:
        return Colors.transparent;
      case TransactionType.expense:
        return Colors.red;
      case TransactionType.income:
        return Colors.green;
      case TransactionType.transfer:
        return Colors.orange;
    }
  }
}

class TransactionViewModel {
  final String id;
  final TransactionType type;
  final String description;
  final List<String> categoriesName;
  final Color mainColor;
  final List<String> acountNames;
  final String icon;
  final DateTime date;
  final double amount;
  final bool isActive = false;

  TransactionViewModel({
    required this.id,
    required this.type,
    required this.description,
    required this.acountNames,
    required this.mainColor,
    required this.icon,
    required this.amount,
    required this.categoriesName,
    required this.date,
  });
}
