import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/screens/enter_pin_screen/screen.dart';
import 'package:finanzas_lite/screens/register_screen/screen.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginEmailState extends GetxController {
  final emailController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();

    final email = await SharedPreferencesMethods.getEmail();

    if (email != null) {
      Get.to(() => const EnterPinScreen(), arguments: email);
    }
  }

  void continueWithEmail() async {
    final email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Error', 'Ingresa un correo válido');
      return;
    }

    // Verificar en Supabase si existe
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('user_profiles')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (response == null) {
        Get.to(() => const RegisterScreen(), arguments: email);
        return;
      }

      Get.to(() => const EnterPinScreen(), arguments: email);
    } catch (e) {
      DelightToastBar(
        autoDismiss: true, // mejor UX: se cierra solo
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Ocurrió un error al verificar el correo",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
