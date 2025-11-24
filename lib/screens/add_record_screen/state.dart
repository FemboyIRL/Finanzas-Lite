import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/screens/accounts_screen/screen.dart';
import 'package:finanzas_lite/overlays/select_account.dart';
import 'package:finanzas_lite/overlays/select_category.dart';
import 'package:finanzas_lite/screens/add_record_screen/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRecordState extends AddRecordResources {
  @override
  void onInit() async {
    super.onInit();
    await supabase.init();

    categories.addAll(await supabase.fetchCategories());
    update();
  }

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
