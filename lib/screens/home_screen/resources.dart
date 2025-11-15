import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeResources extends GetxController {
  // Datos dummies (de prueba) TODO: sacarlos de supabase
  final budgets = <BudgetViewModel>[
    BudgetViewModel(
      id: '1',
      color: Color(0xFFFFD466),
      name: "Comida",
      currentAmountSpent: 3430,
      limit: 5000,
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFF66FFA3),
      name: "Transporte",
      currentAmountSpent: 430,
      limit: 800,
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFF3DB9FF),
      name: "Salud",
      currentAmountSpent: 3000,
      limit: 5000.25,
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFFFFD466),
      name: "Vida Diaría DEL PEPE Y ETE SECH",
      currentAmountSpent: 2500,
      limit: 5000,
    ),
  ];

  final List<CategoryViewModel> categories = [
    CategoryViewModel(
      name: "Comida",
      currentAmountSpent: 3400,
      color: const Color(0xFF6A66FF),
    ),
    CategoryViewModel(
      name: "Transporte",
      currentAmountSpent: 1200,
      color: const Color(0xFFFFD466),
    ),
    CategoryViewModel(
      name: "Entretenimiento",
      currentAmountSpent: 800,
      color: const Color(0xFF66FF99),
    ),
    CategoryViewModel(
      name: "Salud",
      currentAmountSpent: 600,
      color: const Color(0xFFFF6666),
    ),
  ];

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

  // Calcular total gastado por todas las cate
  late double total = categories.fold(
    0,
    (sum, c) => sum + c.currentAmountSpent,
  );
}
