import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterState extends GetxController {
  final pinController = TextEditingController();

  Future<void> createAccount() async {
    final pin = pinController.text.trim();
    final email = Get.arguments as String;

    if (pin.length != 6 || int.tryParse(pin) == null) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "El PIN debe tener 6 digitos",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
      return;
    }

    try {
      final supabase = Supabase.instance.client;

      // Crear el usuario en auth primero
      final authResponse = await supabase.auth.signUp(
        email: email.trim(),
        password: pin,
      );

      if (authResponse.user == null) {
        DelightToastBar(
          autoDismiss: true,
          builder: (context) => const ToastCard(
            leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
            title: Text(
              "Ocurrió un error al registrar la cuenta",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          position: DelightSnackbarPosition.top,
        ).show(Get.context!);
        return;
      }

      final userId = authResponse.user!.id;

      // Guardar también en user_profiles
      await supabase.from('user_profiles').insert({
        'id': userId,
        'email': email,
        'pin_code': pin,
      });

      // Navegar a pantalla inicial
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      print(e);
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Ocurrió un error al registrar la cuenta",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
