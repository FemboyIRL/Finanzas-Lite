import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/overlays/add_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SelectCategoryOverlay extends StatelessWidget {
  final List<CategoryViewModel> categories;
  final Function(CategoryViewModel) onSelectCategory;
  const SelectCategoryOverlay({
    super.key,
    required this.categories,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return FullScreenOverlay(
      title: 'Seleccionar Categoría',
      child: Column(
        children: [
          ...categories.map((cat) => _buildCategoryEntry(cat)).toList(),

          const SizedBox(height: 10),

          _buildAddNewCategory(context),
        ],
      ),
    );
  }

  Padding _buildCategoryEntry(CategoryViewModel category) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          onSelectCategory(category);
          Navigator.of(Get.context!).pop();
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  category.icon,
                  colorFilter: ColorFilter.mode(
                    category.color,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              category.name,
              style: const TextStyle(fontSize: 19, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewCategory(BuildContext context) {
    return GestureDetector(
      onTap: () => onAddCategory(context),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add, size: 30, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Agregar nueva categoría",
            style: const TextStyle(fontSize: 19, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void onAddCategory(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddCategoryOverlay()));
  }
}
