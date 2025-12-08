import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/overlays/select_color/overlay.dart';
import 'package:finanzas_lite/utils/color_helper.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBudgetState extends GetxController {
  var budgetName = "".obs;
  var budgetAmount = 0.obs;
  var selectedColor = Color(0xFF6A66FF).obs;
  var selectedAccounts = RxList<AccountViewModel>();
  var selectedCategories = RxList<CategoryViewModel>();
  final supabase = SupabaseHelper();

  final nameController = TextEditingController();
  final amountController = TextEditingController();

  void onCreateBudget(BuildContext context) async {
    final userId = await SharedPreferencesMethods.getUserId();

    // 1. Insertar el presupuesto
    final budgetResponse = await supabase.supabase
        .from("budgets")
        .insert({
          "user_id": userId!,
          "name": budgetName.value,
          "color_hex": ColorHelper.colorToHex(selectedColor.value),
          "limit_amount": budgetAmount.value,
          "month": DateTime(
            DateTime.now().year,
            DateTime.now().month,
            1,
          ).toIso8601String(),
        })
        .select()
        .single();

    // 2.- Obtener el id de la response
    final String budgetId = budgetResponse["id"];

    // 3. Crear los registros de budget_categories
    final categoryInserts = selectedCategories.map((category) {
      return {"budget_id": budgetId, "category_id": category.id};
    }).toList();

    // 4. Insertar en la tabla puente
    if (categoryInserts.isNotEmpty) {
      await supabase.supabase.from("budget_categories").insert(categoryInserts);
    }

    // 6.- Crear los registros de budget_accounts
    final accountsInserts = selectedAccounts.map((acc) {
      return {"budget_id": budgetId, "account_id": acc.id};
    }).toList();

    // 7.- Insertar en la tabla puente
    if (accountsInserts.isNotEmpty) {
      await supabase.supabase.from("budget_accounts").insert(accountsInserts);
    }

    DelightToastBar(
      autoDismiss: true,
      builder: (context) => const ToastCard(
        leading: Icon(Icons.check_circle, size: 28, color: Colors.green),
        title: Text(
          "Presupuesto creado exitosamente",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      position: DelightSnackbarPosition.top,
    ).show(Get.context!);

    Navigator.of(context).pop();
    update();
  }

  void onTapColor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            SelectColorOverlay(onSave: (Color color) => pickColor(color)),
      ),
    );
  }

  void pickColor(Color color) => selectedColor.value = color;

  void pickCategories(List<CategoryViewModel> categories) {
    selectedCategories.clear();
    selectedCategories.addAll(categories);
    update();
  }

  void pickAccounts(List<AccountViewModel> accounts) {
    selectedAccounts.clear();
    selectedAccounts.addAll(accounts);
    update();
  }

  void editAmount() {
    amountController.text = budgetAmount.value.toString();

    Get.dialog(
      AlertDialog(
        title: Text("Editar cantidad"),
        content: TextField(
          controller: amountController,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Cantidad",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("Cancelar")),
          TextButton(
            onPressed: () {
              final newAmount =
                  double.tryParse(amountController.text) ?? budgetAmount.value;
              budgetAmount.value = newAmount.toInt();
              Get.back();
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }

  void editName() {
    nameController.text = budgetName.value;
    Get.dialog(
      AlertDialog(
        title: Text("Editar nombre"),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Nombre de presupuesto",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("Cancelar")),
          TextButton(
            onPressed: () {
              budgetName.value = nameController.text;
              Get.back();
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
