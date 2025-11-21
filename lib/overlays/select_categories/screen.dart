import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/overlays/select_categories/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SelectCategoriesOverlay extends StatelessWidget {
  final Function(List<CategoryViewModel>) onSave;
  final List<CategoryViewModel> categories;

  const SelectCategoriesOverlay({
    super.key,
    required this.onSave,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectCategoriesState>(
      init: SelectCategoriesState(),
      builder: (state) => FullScreenOverlay(
        title: "Seleccionar Categorías",
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: categories
                    .map((cat) => _buildCategoryEntry(cat, state))
                    .toList(),
              ),
            ),

            const SizedBox(height: 25),

            // Botón Guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onSave(state.selected);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A66FF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Guardar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildCategoryEntry(
    CategoryViewModel category,
    SelectCategoriesState state,
  ) {
    final selected = state.isSelected(category);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => state.toggle(category),
        child: Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Icono + nombre
              if (selected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.greenAccent,
                  size: 28,
                )
              else
                const Icon(
                  Icons.circle_outlined,
                  color: Colors.white54,
                  size: 28,
                ),
              SizedBox(width: 20),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
