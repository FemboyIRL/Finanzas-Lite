import 'dart:ui';

import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecordDetailsState extends GetxController {
  final transactions = [
    TransactionViewModel(
      acountNames: ["Cuenta principal"],
      mainColor: const Color(0xFF6A66FF),
      icon: "assets/svgs/categoryIcons/comida.svg",
      amount: 120.50,
      categoriesName: ["Comida", "Restaurante"],
      date: DateTime.now().subtract(const Duration(days: 1)),
      id: '1',
      type: TransactionType.expense,
      description: 'Papubuelo se nos fue',
    ),
    TransactionViewModel(
      acountNames: ["Tarjeta crédito"],
      mainColor: const Color(0xFFE840D1),
      icon: "assets/svgs/categoryIcons/maleta.svg",
      amount: 890.20,
      categoriesName: ["Compras", "Ropa"],
      date: DateTime.now().subtract(const Duration(days: 3)),
      id: '2',
      type: TransactionType.income,
      description: 'Papubuelo se nos fue',
    ),
    TransactionViewModel(
      acountNames: ["Cuenta de ahorro"],
      mainColor: const Color(0xFF4CAF50),
      icon: "assets/svgs/categoryIcons/bicicleta.svg",
      amount: -45.00,
      categoriesName: ["Transporte"],
      date: DateTime.now().subtract(const Duration(days: 5)),
      id: '3',
      type: TransactionType.transfer,
      description: 'Papubuelo se nos fue',
    ),
  ];

  void onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onTapSave() {}

  void onTapDelete() {}
}
