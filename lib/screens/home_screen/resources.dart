import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeResources extends GetxController {
  final budgets = <Budget>[
    Budget(
      color: Color(0xFFFFD466),
      name: "Comida",
      currentAmountSpent: 3430,
      limit: 5000,
    ),
    Budget(
      color: Color(0xFF66FFA3),
      name: "Transporte",
      currentAmountSpent: 430,
      limit: 800,
    ),
    Budget(
      color: Color(0xFF3DB9FF),
      name: "Salud",
      currentAmountSpent: 3000,
      limit: 5000.25,
    ),
    Budget(
      color: Color(0xFFFFD466),
      name: "Vida Diaría DEL PEPE Y ETE SECH",
      currentAmountSpent: 2500,
      limit: 5000,
    ),
  ];
}

class Budget {
  final Color color;
  final String name;
  final double limit;
  final double currentAmountSpent;

  const Budget({
    required this.color,
    required this.name,
    required this.currentAmountSpent,
    required this.limit,
  });
}
