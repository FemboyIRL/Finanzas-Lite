import 'dart:ui';

class CategoryViewModel {
  //TODO: Agregar un onTapGesture
  final String name;
  final double currentAmountSpent;
  final Color color;

  const CategoryViewModel({
    required this.currentAmountSpent,
    required this.color,
    required this.name,
  });
}
