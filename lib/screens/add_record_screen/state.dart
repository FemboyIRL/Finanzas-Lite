import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/screens/accounts_screen/screen.dart';
import 'package:finanzas_lite/overlays/select_account.dart';
import 'package:finanzas_lite/overlays/select_category.dart';
import 'package:finanzas_lite/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRecordState extends GetxController {
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
  var selectedRecordType = 1.obs;
  var selectedFromAccount = Rxn<AccountViewModel>();
  var selectedAccount = Rxn<AccountViewModel>();
  var selectedCategory = Rxn<CategoryViewModel>();
  var inputText = "0".obs;

  void changeSelectedRecordType(int idx) {
    if (idx != 3) {
      selectedFromAccount.value = null;
    }
    selectedRecordType.value = idx;
  }

  void onGoBack() {
    Navigator.of(Get.context!).pop();
  }

  void onTapSelectAccount(BuildContext context, int selectedOption) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectAccountOverlay(
          accounts: accounts,
          onAddAccount: () => onTapAddAccount(),
          onSelectAccount: (AccountViewModel account) {
            onSelectAccount(selectedOption, account);
          },
        ),
      ),
    );
  }

  void onTapSelectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectCategoryOverlay(
          categories: categories,
          onSelectCategory: (CategoryViewModel category) {
            onSelectCategory(category);
          },
        ),
      ),
    );
  }

  void onTapAddAccount() {
    Navigator.of(
      Get.context!,
    ).push(MaterialPageRoute(builder: (context) => const AccountsScreen()));
  }

  void onSelectCategory(CategoryViewModel category) {
    selectedCategory.value = category;
  }

  void onSelectAccount(int selectedOption, AccountViewModel account) {
    if (selectedOption == 1) {
      selectedAccount.value = account;
    } else {
      selectedFromAccount.value = account;
    }
  }

  void onTapSelectFromAccount(BuildContext context) {}

  void onKeyPressed(String value) {
    // Evitar múltiples puntos decimales
    if (value == '.' && inputText.value.contains('.')) return;

    // Evitar ceros iniciales innecesarios
    if (inputText.value == '0' && value != '.') {
      inputText.value = value;
      return;
    }

    // Límite de longitud
    if (inputText.value.length >= 9) return;

    inputText.value += value;
  }

  void onBackspacePressed() {
    if (inputText.value.isNotEmpty) {
      inputText.value = inputText.value.substring(
        0,
        inputText.value.length - 1,
      );
    }

    if (inputText.value.isEmpty) {
      inputText.value = '0';
    }
  }
}
