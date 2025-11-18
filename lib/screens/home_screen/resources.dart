import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:finanzas_lite/utils/icons.dart';
import 'package:flutter/material.dart';
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
      transactions: [],
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFF66FFA3),
      name: "Transporte",
      currentAmountSpent: 430,
      limit: 800,
      transactions: [],
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFF3DB9FF),
      name: "Salud",
      currentAmountSpent: 3000,
      limit: 5000.25,
      transactions: [],
    ),
    BudgetViewModel(
      id: '1',
      color: Color(0xFFFFD466),
      name: "Vida Diaría DEL PEPE Y ETE SECH",
      currentAmountSpent: 2500,
      limit: 5000,
      transactions: [],
    ),
  ];

  final categories = [
    CategoryViewModel(
      name: "Comida",
      icon: AppIcons.getIconPath(4), // comida.svg
      color: Colors.orange,
      currentAmountSpent: 1250.75,
    ),
    CategoryViewModel(
      name: "Transporte",
      icon: AppIcons.getIconPath(1), // bus.svg
      color: Colors.blue,
      currentAmountSpent: 450.50,
    ),
    CategoryViewModel(
      name: "Compras",
      icon: AppIcons.getIconPath(11), // shopping.svg
      color: Colors.purple,
      currentAmountSpent: 3200.00,
    ),
    CategoryViewModel(
      name: "Salud",
      icon: AppIcons.getIconPath(5), // face.svg
      color: Colors.red,
      currentAmountSpent: 800.25,
    ),
    CategoryViewModel(
      name: "Entretenimiento",
      icon: AppIcons.getIconPath(9), // palace.svg
      color: Colors.green,
      currentAmountSpent: 600.00,
    ),
  ];

  final accounts = [
    AccountViewModel(
      name: "Cuenta Principal",
      owner: "Luis García",
      expirationDate: "12/25",
      lastFourNumbers: "4532",
      type: AccountType.debit,
      currentAmount: 15420.75,
    ),
    AccountViewModel(
      name: "Tarjeta Crédito",
      owner: "Luis García",
      expirationDate: "08/26",
      lastFourNumbers: "7890",
      type: AccountType.credit,
      currentAmount: -3200.50,
    ),
    AccountViewModel(
      name: "Ahorros",
      owner: "Luis García",
      expirationDate: "N/A",
      lastFourNumbers: "1234",
      type: AccountType.savings,
      currentAmount: 25300.00,
    ),
  ];

  late final transactions = [
    TransactionViewModel(
      id: "1",
      type: TransactionType.expense,
      description: "Supermercado La Canasta",
      category: categories[0], // Comida
      mainColor: Colors.orange,
      account: accounts[0], // Cuenta Principal
      icon: AppIcons.getIconPath(4), // comida.svg
      date: DateTime(2024, 1, 15, 14, 30),
      amount: -350.75,
    ),
    TransactionViewModel(
      id: "2",
      type: TransactionType.expense,
      description: "Gasolina Estación Shell",
      category: categories[1], // Transporte
      mainColor: Colors.blue,
      account: accounts[0], // Cuenta Principal
      icon: AppIcons.getIconPath(2), // car.svg
      date: DateTime(2024, 1, 14, 10, 15),
      amount: -200.00,
    ),
    TransactionViewModel(
      id: "3",
      type: TransactionType.income,
      description: "Pago de Nómina",
      category: CategoryViewModel(
        name: "Salario",
        icon: AppIcons.getIconPath(3), // cash.svg
        color: Colors.green,
        currentAmountSpent: 0,
      ),
      mainColor: Colors.green,
      account: accounts[0], // Cuenta Principal
      icon: AppIcons.getIconPath(3), // cash.svg
      date: DateTime(2024, 1, 10, 9, 0),
      amount: 15000.00,
    ),
    TransactionViewModel(
      id: "4",
      type: TransactionType.expense,
      description: "Zapatos Deportivos",
      category: categories[2], // Compras
      mainColor: Colors.purple,
      account: accounts[1], // Tarjeta Crédito
      icon: AppIcons.getIconPath(11), // shopping.svg
      date: DateTime(2024, 1, 12, 16, 45),
      amount: -1200.00,
    ),
    TransactionViewModel(
      id: "5",
      type: TransactionType.expense,
      description: "Cena Restaurante Italiano",
      category: categories[0], // Comida
      mainColor: Colors.orange,
      account: accounts[0], // Cuenta Principal
      icon: AppIcons.getIconPath(4), // comida.svg
      date: DateTime(2024, 1, 13, 20, 30),
      amount: -480.50,
    ),
  ];

  // Calcular total gastado por todas las cate
  late double total = categories.fold(
    0,
    (sum, c) => sum + c.currentAmountSpent,
  );
}
