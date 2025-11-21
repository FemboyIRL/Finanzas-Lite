import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/overlays/budgets_menu_overlay.dart';
import 'package:finanzas_lite/overlays/create_budget/overlay.dart';
import 'package:finanzas_lite/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class BudgetsState extends GetxController {
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
      currentAmountSpent: 4300,
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

  final accounts = [
    AccountViewModel(
      name: "Tarjeta Oro PERO ASI BIEN DEL MAL",
      currentAmount: 12500.75,
      expirationDate: "08/27",
      lastFourNumbers: "4821",
      owner: "Luis C. Ruiz",
      type: AccountType.cash,
    ),
    AccountViewModel(
      name: "Cuenta Débito",
      currentAmount: 3540.20,
      expirationDate: "05/26",
      lastFourNumbers: "9214",
      owner: "Luis C. Ruiz",
      type: AccountType.savings,
    ),
    AccountViewModel(
      name: "Tarjeta Digital",
      currentAmount: 820.90,
      expirationDate: "12/28",
      lastFourNumbers: "1078",
      owner: "Luis C. Ruiz",
      type: AccountType.credit,
    ),
  ].obs;
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

  void onTapNewBudget(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CreateBudgetOverlay(categories: categories, accounts: accounts),
      ),
    );
  }

  void onTapOpenMenu(BuildContext context, BudgetViewModel budget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BudgetsMenuOverlay(budget: budget),
      ),
    );
  }

  void onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
