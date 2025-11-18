import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/utils/progress_bar.dart';
import 'package:flutter/material.dart';

class StatisticsInfoBar extends StatelessWidget {
  final CategoryViewModel category;
  final double total;
  const StatisticsInfoBar({
    super.key,
    required this.category,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.name),
              Text(category.currentAmountSpent.toStringAsFixed(2)),
            ],
          ),
          SizedBox(height: 10),
          ProgressBar(
            barHeight: 20,
            limit: total,
            spent: category.currentAmountSpent,
            color: category.color,
          ),
        ],
      ),
    );
  }
}
