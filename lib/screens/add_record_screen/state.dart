import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/screens/accounts_screen/screen.dart';
import 'package:finanzas_lite/overlays/select_account.dart';
import 'package:finanzas_lite/overlays/select_category.dart';
import 'package:finanzas_lite/screens/add_record_screen/resources.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRecordState extends AddRecordResources {
  @override
  void onInit() async {
    super.onInit();
    await supabase.init();
    await fetchData();
  }

  @override
  void onClose() {
    selectedAccount.close();
    selectedCategory.close();
    selectedFromAccount.close();
    selectedRecordType.close();
    inputText.value = "0";
    descriptionController.clear();
    super.onClose();
  }

  Future<void> fetchData() async {
    categories.addAll(await supabase.fetchCategories());
    accounts.addAll(await supabase.fetchAccounts());
    update();
  }

  void changeSelectedRecordType(String type) {
    if (type != "transfer") {
      selectedFromAccount.value = null;
    }
    selectedRecordType.value = type;
  }

  void onGoBack(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
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

  void onTapAddTransaction() async {
    final userId = await SharedPreferencesMethods.getUserId();
    final description = descriptionController.text.trim();

    if (selectedCategory.value == null) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Error: selecciona una categoría",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
      return;
    }

    if (selectedAccount.value == null) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Error: No puedes transferir hacia la misma cuenta",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
      return;
    }

    if (selectedRecordType.value == "transfer") {
      // Validación de transferencia: no permitir misma cuenta
      if (selectedFromAccount.value!.id == selectedAccount.value!.id) {
        DelightToastBar(
          autoDismiss: true,
          builder: (context) => const ToastCard(
            leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
            title: Text(
              "Error: No puedes transferir hacia la misma cuenta",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          position: DelightSnackbarPosition.top,
        ).show(Get.context!);
        return;
      }

      final map = {
        "user_id": userId,
        "type": "transfer",
        "from_account_id": selectedFromAccount.value!.id,
        "to_account_id": selectedAccount.value!.id,
        "amount": double.parse(inputText.value),
        "transaction_date": DateTime.now().toIso8601String(),
      };

      await _insertTransaction(map);
      return;
    }

    // Gasto o ingreso
    final map = {
      "user_id": userId,
      "type": selectedRecordType.value,
      "description": description,
      "category_id": selectedCategory.value?.id,
      "account_id": selectedAccount.value!.id,
      "amount": double.parse(inputText.value),
      "transaction_date": DateTime.now().toIso8601String(),
    };

    await _insertTransaction(map);
  }

  Future<void> _insertTransaction(Map<String, dynamic> map) async {
    try {
      await supabase.supabase.from("transactions").insert(map);

      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.check_circle, size: 28, color: Colors.green),
          title: Text(
            "Transacción registrada con éxito",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
      onGoBack(Get.context!);
    } catch (e) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Ocurrió un error al registrar la transacción",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);

      print("Transaction error: $e");
    }
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
    final from = selectedFromAccount.value;
    final to = selectedAccount.value;

    if (selectedOption == 1) {
      if (from != null && from.id == account.id) {
        DelightToastBar(
          autoDismiss: true,
          builder: (context) => const ToastCard(
            leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
            title: Text(
              "Error: No puedes transferir hacia la misma cuenta",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          position: DelightSnackbarPosition.top,
        ).show(Get.context!);
        return;
      }

      selectedAccount.value = account;
    } else {
      if (to != null && to.id == account.id) {
        DelightToastBar(
          autoDismiss: true,
          builder: (context) => const ToastCard(
            leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
            title: Text(
              "Error: No puedes transferir desde la misma cuenta",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          position: DelightSnackbarPosition.top,
        ).show(Get.context!);
        return;
      }

      selectedFromAccount.value = account;
    }
  }

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
