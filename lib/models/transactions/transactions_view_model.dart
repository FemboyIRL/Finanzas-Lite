import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
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
  final String userId;
  final TransactionType type;
  final String description;
  final CategoryViewModel category;
  final Color mainColor;
  final AccountViewModel account;
  final String icon;
  final DateTime date;
  final double amount;
  final bool isActive = false;

  TransactionViewModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.description,
    required this.account,
    required this.mainColor,
    required this.icon,
    required this.amount,
    required this.category,
    required this.date,
  });

  factory TransactionViewModel.fromJson(Map<String, dynamic> json) {
    return TransactionViewModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: transactionTypeFromString(json['type'] as String),
      description: json['description'] as String,
      icon: json['icon'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      mainColor: Color(json['mainColor'] as int),

      // Objetos anidados
      category: CategoryViewModel.fromJson(json['category']),
      account: AccountViewModel.fromJson(json['account']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': transactionTypeToString(type),
      'description': description,
      'icon': icon,
      'amount': amount,
      'date': date.toIso8601String(),
      'mainColor': mainColor.value,

      // Objetos anidados
      'category': category.toJson(),
      'account': account.toJson(),
    };
  }

  static TransactionType transactionTypeFromString(String value) {
    switch (value) {
      case "zero":
        return TransactionType.zero;
      case "expense":
        return TransactionType.expense;
      case "income":
        return TransactionType.income;
      case "transfer":
        return TransactionType.transfer;
      default:
        return TransactionType.zero;
    }
  }

  static String transactionTypeToString(TransactionType type) {
    switch (type) {
      case TransactionType.zero:
        return "";
      case TransactionType.expense:
        return "expense";
      case TransactionType.income:
        return "income";
      case TransactionType.transfer:
        return "transfer";
    }
  }
}
