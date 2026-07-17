import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/overlays/create_budget/overlay.dart';
import 'package:finanzas_lite/overlays/select_category/select_category.dart';
import 'package:finanzas_lite/overlays/select_color_icon/select_color_icon.dart';
import 'package:finanzas_lite/screens/add_record_screen/screen.dart';
import 'package:finanzas_lite/utils/color_helper.dart';
import 'package:finanzas_lite/utils/icons.dart';
import 'package:finanzas_lite/utils/shared_preferences.dart';
import 'package:finanzas_lite/utils/supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  var selectedColor = Color(0xFF6A66FF).obs;
  var selectedIcon = 0.obs;
  var categoryName = "Cuenta".obs;
  final nameController = TextEditingController();
  final supabase = SupabaseHelper();

  void addCategory() async {
    final name = nameController.text.trim();
    final userId = await SharedPreferencesMethods.getUserId();

    if (name.isEmpty) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Error: El nombre está vacio",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
      return;
    }

    final categoryMap = {
      "user_id": userId,
      "name": name,
      "icon_index": selectedIcon.value,
      "color_hex": ColorHelper.colorToHex(selectedColor.value),
      "amount_spent": 0,
    };

    try {
      await supabase.supabase.from("categories").insert(categoryMap);
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.check_circle, size: 28, color: Colors.green),
          title: Text(
            "Categoría agregada exitosamente",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);

      selectedColor = Color(0xFF6A66FF).obs;
      selectedIcon = 0.obs;
      categoryName = "Cuenta".obs;

      nameController.clear();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      DelightToastBar(
        autoDismiss: true,
        builder: (context) => const ToastCard(
          leading: Icon(Icons.error_outline, size: 28, color: Colors.red),
          title: Text(
            "Error al agregar la categoría",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        position: DelightSnackbarPosition.top,
      ).show(Get.context!);
    }
  }

  void editName() {
    nameController.text = categoryName.value;

    Get.dialog(
      AlertDialog(
        title: Text("Editar nombre"),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Nombre de categoría",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("Cancelar")),
          TextButton(
            onPressed: () {
              categoryName.value = nameController.text;
              Get.back();
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }
}

// En tu widget:
class AddCategoryOverlay extends StatelessWidget {
  final AddCategoryController controller = Get.put(AddCategoryController());

  @override
  Widget build(BuildContext context) {
    return FullScreenOverlay(
      title: "Agregar Categoría",
      child: Column(
        children: [
          Expanded(
            child: Column(children: [_iconEntry(context), _nameEntry()]),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.addCategory(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A66FF),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Agregar Categoría",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameEntry() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () => controller.editName(),
        child: Row(
          children: [
            Text("Nombre", style: TextStyle(fontSize: 18)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: controller.editName,
                      child: Text(
                        controller.categoryName.value,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(Icons.edit, color: Colors.white, size: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _iconEntry(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () => onTapIcon(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Icono", style: TextStyle(fontSize: 18)),
            Obx(
              () => Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: controller.selectedColor.value.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                    50,
                  ), // Opcional: bordes redondeados
                ),
                child: Stack(
                  children: [
                    // Icono principal con fit
                    Center(
                      child: SvgPicture.asset(
                        AppIcons.getIconPath(controller.selectedIcon.value),
                        height: 30, // Tamaño controlado
                        width: 30,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          controller.selectedColor.value,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    // Círculo pequeño con lápiz
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.edit, color: Colors.white, size: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapIcon(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectColorAndIconOverlay(
          onSave: (Color color, int iconIdx) => onSaveIconColor(color, iconIdx),
        ),
      ),
    );
  }

  void onSaveIconColor(Color color, int iconIdx) {
    controller.selectedColor.value = color;
    controller.selectedIcon.value = iconIdx;
  }
}
