import 'dart:ui';

class BudgetViewModel {
  //TODO: Agregar un onTapGesture
  final Color color;
  final String name;
  final double limit;
  final double currentAmountSpent;

  const BudgetViewModel({
    required this.color,
    required this.name,
    required this.currentAmountSpent,
    required this.limit,
  });
}
