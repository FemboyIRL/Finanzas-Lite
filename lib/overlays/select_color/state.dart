import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectColorState extends GetxController {
  final availableColors = [
    const Color(0xFF6A66FF),
    const Color(0xFF66FFA3),
    const Color(0xFFFF9466),
    const Color(0xFFFF66E7),
    const Color(0xFFDB3C3C),
    const Color(0xFFFFFFFF),
    const Color(0xFF9747FF),
    const Color(0xFF66DAFF),
  ];

  var selectedColor = Color(0xFF6A66FF).obs;

  void pickColor(Color c) => selectedColor.value = c;
}
