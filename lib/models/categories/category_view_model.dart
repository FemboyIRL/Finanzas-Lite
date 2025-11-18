import 'dart:ui';

class CategoryViewModel {
  //TODO: Agregar un onTapGesture
  final String name;
  final String icon;
  final double currentAmountSpent;
  final Color color;

  const CategoryViewModel({
    required this.currentAmountSpent,
    required this.icon,
    required this.color,
    required this.name,
  });
}
