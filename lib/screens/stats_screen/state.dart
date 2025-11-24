import 'dart:ui';

import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:get/get.dart';

class StatisticsState extends GetxController {
  final List<CategoryViewModel> categories = [];
  late double total = categories.fold(
    0,
    (sum, c) => sum + c.currentAmountSpent,
  );
}
