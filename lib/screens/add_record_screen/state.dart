import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRecordState extends GetxController {
  var selectedRecordType = 1.obs;
  var selectedAccount = "".obs;
  var inputText = "0".obs;

  void changeSelectedRecordType(int idx) {
    selectedRecordType.value = idx;
  }

  void onGoBack() {
    Navigator.of(Get.context!).pop();
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
