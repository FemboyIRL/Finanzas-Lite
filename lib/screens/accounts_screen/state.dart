import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsState extends GetxController {
  final accounts = [].obs;
  final supabase = SupabaseHelper();

  // Controladores del formulario
  final nameCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final ownerCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  AccountType selectedType = AccountType.cash;

  void addAccount() async {
    final userId = await SharedPreferencesMethods.getUserId();

    final map = {
      "user_id": userId!,
      "name": nameCtrl.text.trim(),
      "last_four_numbers": numberCtrl.text.trim(),
      "expiration_date": expCtrl.text.trim(),
      "owner": ownerCtrl.text.trim(),
      "current_amount": double.tryParse(amountCtrl.text) ?? 0,
      "type": selectedType.dbValue,
    };

    try {
      await supabase.supabase.from("accounts").insert(map);

      // Refetch inmediato
      final newAccounts = await supabase.fetchAccounts();
      accounts.assignAll(newAccounts);

      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.check_circle, size: 28, color: Colors.green),
          title: Text(
            "Cuenta agregada exitosamente",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
    } catch (e) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error, size: 28, color: Colors.red),
          title: Text(
            "Error al agregar la cuenta",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
    }

    // Limpiar inputs después de guardar
    nameCtrl.clear();
    numberCtrl.clear();
    expCtrl.clear();
    ownerCtrl.clear();
    amountCtrl.clear();
    selectedType = AccountType.cash;

    update();
  }

  final pageController = PageController();
  final currentPage = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    await supabase.init();

    accounts.addAll(await supabase.fetchAccounts());

    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      currentPage.value = page;
    });

    update();
  }

  @override
  void onClose() {
    accounts.clear();
    pageController.dispose();
    super.onClose();
  }
}
