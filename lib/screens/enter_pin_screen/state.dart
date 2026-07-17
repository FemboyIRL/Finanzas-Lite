import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EnterPinState extends GetxController {
  final inputText = "".obs;
  String? PIN;
  String? userId;
  var email = "";

  @override
  void onInit() async {
    super.onInit();

    final emailFromDb = await SharedPreferencesMethods.getEmail();

    if (emailFromDb != null) {
      email = emailFromDb;
    } else {
      email = Get.arguments as String;
    }

    await getUserData();
  }

  Future<void> getUserData() async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('user_profiles')
          .select("pin_code, id")
          .eq("email", email)
          .single();

      if (response.isEmpty) {
        return;
      }

      userId = response["id"];
      PIN = response["pin_code"];
    } catch (e) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Ocurrió un error al obtener el pin",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
      return;
    }
  }

  void onKeyPressed(String value) async {
    // Solo permite números y máximo 6 dígitos
    if (inputText.value.length >= 6) return;

    inputText.value += value;

    // Cuando ya tiene 6 dígitos, validar
    if (inputText.value.length == 6) {
      if (inputText.value == PIN) {
        DelightToastBar(
          autoDismiss: true,
          builder: (context) => const ToastCard(
            leading: Icon(Icons.waving_hand, size: 28, color: Colors.green),
            title: Text(
              "Bienvenido",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          position: DelightSnackbarPosition.top,
        ).show(Get.context!);
        await SharedPreferencesMethods.setEmail(email);
        await SharedPreferencesMethods.setUserId(userId!);
        Navigator.of(
          Get.context!,
        ).push(MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        // Reinicia el input si el PIN es incorrecto
        inputText.value = "";

        DelightToastBar(
          autoDismiss: true,
          builder: (context) => const ToastCard(
            leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
            title: Text(
              "PIN incorrecto",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          position: DelightSnackbarPosition.top,
        ).show(Get.context!);
      }
    }
  }

  void onBackspacePressed() {
    if (inputText.value.isNotEmpty) {
      inputText.value = inputText.value.substring(
        0,
        inputText.value.length - 1,
      );
    }
  }
}
