import 'package:finanzas_lite/screens/budgets_screen/screen.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetMenuState extends GetxController {
  final supabase = SupabaseHelper();

  @override
  void onInit() async {
    super.onInit();

    await supabase.init();
  }

  Future<void> onDeleteBudget(String id) async {
    await supabase.deleteBudget(id);

    Navigator.of(Get.context!).pushReplacement(
      MaterialPageRoute(builder: (context) => const BudgetsScreen()),
  );
  }
}
