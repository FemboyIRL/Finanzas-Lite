import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/screens/home_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterPinState extends GetxController {
  final inputText = "".obs;
  final String PIN = "0101";

  void onKeyPressed(String value) {
    // Solo permite números y máximo 4 dígitos
    if (inputText.value.length >= 4) return;

    inputText.value += value;

    // Cuando ya tiene 4 dígitos, validar
    if (inputText.value.length == 4) {
      if (inputText.value == PIN) {
        Navigator.of(
          Get.context!,
        ).push(MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        // Reinicia el input si el PIN es incorrecto
        inputText.value = "";

        DelightToastBar(
          autoDismiss: true, // mejor UX: se cierra solo
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
