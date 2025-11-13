import 'package:finanzas_lite/components/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordsState extends GetxController {
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
      acountNames: ["Cuenta principal"],
      mainColor: const Color(0xFF6A66FF),
      icon: "assets/svgs/categoryIcons/comida.svg",
      amount: 120.50,
      categoriesName: ["Comida", "Restaurante"],
      date: DateTime.now().subtract(const Duration(days: 1)),
      onDelete: (callback) => debugPrint("Eliminado comida"),
    ),
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
      acountNames: ["Cuenta principal"],
      mainColor: const Color(0xFF6A66FF),
      icon: "assets/svgs/categoryIcons/comida.svg",
      amount: 120.50,
      categoriesName: ["Comida", "Restaurante"],
      date: DateTime.now().subtract(const Duration(days: 1)),
      onDelete: (callback) => debugPrint("Eliminado comida"),
    ),
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

  final searchValue = "".obs;

  void onSearchUpdated(final String newValue) {
    searchValue.value = newValue;
  }

  List<TransactionViewModel> filteredOperations() {
    // Falta agregar otros campos de busqueda, ej: por fecha, por descripcion
    return transactions.where((item) {
      final query = searchValue.value.toLowerCase();

      final searchableText = [
        ...item.acountNames,
        ...item.categoriesName,
        item.amount.toString(),
      ].join(' ').toLowerCase();

      return searchableText.contains(query);
    }).toList();
  }
}
