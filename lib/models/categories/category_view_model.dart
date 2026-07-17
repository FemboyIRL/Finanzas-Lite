import 'dart:ui';

import 'package:finanzas_lite/utils/icons.dart';

class CategoryViewModel {
  final String id;
  final String userId;
  final String name;
  final String icon;
  final double currentAmountSpent;
  final Color color;

  const CategoryViewModel({
    required this.id,
    required this.userId,
    required this.currentAmountSpent,
    required this.icon,
    required this.color,
    required this.name,
  });

  factory CategoryViewModel.fromJson(Map<String, dynamic> json) {
    return CategoryViewModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      icon: AppIcons.getIconPath(json["icon_index"] as int),
      currentAmountSpent: (json['amount_spent'] as num).toDouble(),
      color: Color(int.parse(json['color_hex'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': AppIcons.getIconIndex(icon),
      'currentAmountSpent': currentAmountSpent,
      'color': color.value,
    };
  }
}
