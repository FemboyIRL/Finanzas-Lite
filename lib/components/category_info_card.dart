import 'package:flutter/material.dart';

class CategoryInfoCard extends StatelessWidget {
  final CategoryViewModel category;

  const CategoryInfoCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: category.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: category.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "\$${category.currentAmountSpent}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: category.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryViewModel {
  final String name;
  final double currentAmountSpent;
  final Color color;

  const CategoryViewModel({
    required this.currentAmountSpent,
    required this.color,
    required this.name,
  });
}
