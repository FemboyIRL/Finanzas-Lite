import 'package:get/get.dart';

class HomeResources extends GetxController {
  final budgets = <Budget>[
    Budget(
      color: "FFD466",
      name: "Comida",
      currentAmountSpent: "3,430",
      limit: "5,000",
    ),
    Budget(
      color: "66FFA3",
      name: "Transporte",
      currentAmountSpent: "430",
      limit: "800",
    ),
    Budget(
      color: "3DB9FF",
      name: "Salud",
      currentAmountSpent: "3000",
      limit: "5,000",
    ),
    Budget(
      color: "FFD466",
      name: "Vida Diaría DEL PEPE Y ETE SECH",
      currentAmountSpent: "2500",
      limit: "5,000",
    ),
  ];
}

class Budget {
  final String color;
  final String name;
  final String limit;
  final String currentAmountSpent;

  const Budget({
    required this.color,
    required this.name,
    required this.currentAmountSpent,
    required this.limit,
  });
}
