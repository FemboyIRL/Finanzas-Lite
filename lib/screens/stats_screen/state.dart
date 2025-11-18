import 'dart:ui';

import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:get/get.dart';

class StatisticsState extends GetxController {
  final List<CategoryViewModel> categories = [
    CategoryViewModel(
      name: "Comida",
      currentAmountSpent: 150000,
      color: const Color(0xFF6A66FF),
    ),
    CategoryViewModel(
      name: "Transporte",
      currentAmountSpent: 1200,
      color: const Color(0xFFFFD466),
    ),
    CategoryViewModel(
      name: "Entretenimiento",
      currentAmountSpent: 800,
      color: const Color(0xFF66FF99),
    ),
    CategoryViewModel(
      name: "Salud",
      currentAmountSpent: 600,
      color: const Color(0xFFFF6666),
    ),
  ];
  late double total = categories.fold(
    0,
    (sum, c) => sum + c.currentAmountSpent,
  );
}
