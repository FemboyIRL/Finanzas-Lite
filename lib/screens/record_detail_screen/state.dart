import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordDetailsState extends GetxController {
  final transactions = [];
  final isEditing = false.obs;
  final supabase = SupabaseHelper();

  @override
  void onInit() async {
    super.onInit();
    await supabase.init();
  }

  void onGoBack(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void onTapEdit() {
    // Futuro
    DelightToastBar(
      autoDismiss: true,
      builder: (context) => const ToastCard(
        leading: Icon(Icons.warning, size: 28, color: Colors.yellow),
        title: Text(
          "Proximamente: función para la épica 2",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      position: DelightSnackbarPosition.top,
    ).show(Get.context!);
  }

  Future<void> onTapDelete(String id) async {
    await supabase.deleteTransaction(id);
    DelightToastBar(
      autoDismiss: true,
      builder: (context) => const ToastCard(
        leading: Icon(Icons.check_circle, size: 28, color: Colors.green),
        title: Text(
          "Transacción eliminada exitosamente",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      position: DelightSnackbarPosition.top,
    ).show(Get.context!);
    onGoBack(Get.context!);
  }
}
