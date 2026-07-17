import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SelectColorAndIconState extends GetxController {
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
  var selectedIcon = 0.obs;

  void pickColor(Color c) => selectedColor.value = c;
  void pickIcon(int i) => selectedIcon.value = i;
}
