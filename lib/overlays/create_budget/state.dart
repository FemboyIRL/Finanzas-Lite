import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/overlays/select_categories/screen.dart';
import 'package:finanzas_lite/overlays/select_color/overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBudgetState extends GetxController {
  var budgetName = "".obs;
  var budgetAmount = 0.obs;
  var selectedColor = Color(0xFF6A66FF).obs;
  var selectedAccounts = RxList<AccountViewModel>();
  var selectedCategories = RxList<CategoryViewModel>();

  final nameController = TextEditingController();
  final amountController = TextEditingController();

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
