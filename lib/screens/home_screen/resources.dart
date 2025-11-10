import 'package:finanzas_lite/components/category_info_card.dart';
import 'package:finanzas_lite/components/transaction_widget.dart';
import 'package:finanzas_lite/models/nav_item.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeResources extends GetxController {
  final budgets = <Budget>[
    Budget(
      color: Color(0xFFFFD466),
      name: "Comida",
      currentAmountSpent: 3430,
      limit: 5000,
    ),
    Budget(
      color: Color(0xFF66FFA3),
      name: "Transporte",
      currentAmountSpent: 430,
      limit: 800,
    ),
    Budget(
      color: Color(0xFF3DB9FF),
      name: "Salud",
      currentAmountSpent: 3000,
      limit: 5000.25,
    ),
    Budget(
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
      onDelete: (callback) => debugPrint("Eliminado comida"),
    ),
    TransactionViewModel(
      acountNames: ["Tarjeta crédito"],
      mainColor: const Color(0xFFE840D1),
      icon: "assets/svgs/categoryIcons/maleta.svg",
      amount: 890.20,
      categoriesName: ["Compras", "Ropa"],
      date: DateTime.now().subtract(const Duration(days: 3)),
      onDelete: (callback) => debugPrint("Eliminado compras"),
    ),
    TransactionViewModel(
      acountNames: ["Cuenta de ahorro"],
      mainColor: const Color(0xFF4CAF50),
      icon: "assets/svgs/categoryIcons/bicicleta.svg",
      amount: -45.00,
      categoriesName: ["Transporte"],
      date: DateTime.now().subtract(const Duration(days: 5)),
      onDelete: (callback) => debugPrint("Eliminado transporte"),
    ),
  ];

  late double total = categories.fold(
    0,
    (sum, c) => sum + c.currentAmountSpent,
  );

  final navItems = <NavItem>[
    NavItem(iconPath: "assets/svgs/navbar/Home.svg", route: "/home"),
    NavItem(iconPath: "assets/svgs/navbar/Wallet.svg", route: "/wallet"),
    NavItem(iconPath: "assets/svgs/navbar/Stats.svg", route: "/stats"),
    NavItem(iconPath: "assets/svgs/navbar/User.svg", route: "/profile"),
  ];
}

class Budget {
  final Color color;
  final String name;
  final double limit;
  final double currentAmountSpent;

  const Budget({
    required this.color,
    required this.name,
    required this.currentAmountSpent,
    required this.limit,
  });
}
