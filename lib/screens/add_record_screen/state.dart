import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/screens/add_record_screen/overlays/select_account.dart';
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
  var selectedRecordType = 1.obs;
  var selectedFromAccount = Rxn<AccountViewModel>();
  var selectedAccount = Rxn<AccountViewModel>();
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
          onSelectAccount: (AccountViewModel account) {
            onSelectAccount(selectedOption, account);
          },
        ),
      ),
    );
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
