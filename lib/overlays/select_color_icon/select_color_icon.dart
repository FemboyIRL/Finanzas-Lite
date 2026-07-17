import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/overlays/select_color_icon/state.dart';
import 'package:finanzas_lite/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SelectColorAndIconOverlay extends StatelessWidget {
  final Function(Color, int) onSave;

  const SelectColorAndIconOverlay({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectColorAndIconState>(
      init: SelectColorAndIconState(),
      builder: (state) {
        return FullScreenOverlay(
          title: "Color e Ícono",
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Obx(() {
                  final selectedColor =
                      Get.find<SelectColorAndIconState>().selectedColor.value;

                  return ListView.builder(
                    itemCount: Get.find<SelectColorAndIconState>()
                        .availableColors
                        .length,
                    itemBuilder: (context, idx) {
                      final color = Get.find<SelectColorAndIconState>()
                          .availableColors[idx];
                      final isSelected = selectedColor == color;

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => Get.find<SelectColorAndIconState>()
                              .pickColor(color),
                          child: Container(
                            width: 50, // Un poco más grande para el borde
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: isSelected
                                  ? Border.all(color: color, width: 3)
                                  : null,
                            ),
                            child: Center(
                              child: Container(
                                width:
                                    40, // Más pequeño que el contenedor padre
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  );
                }),
              ),

              Divider(thickness: 2, color: Colors.white),
              // GRID DE ÍCONOS
              Expanded(
                child: Obx(() {
                  final selectedColor =
                      Get.find<SelectColorAndIconState>().selectedColor.value;
                  final selectedIcon =
                      Get.find<SelectColorAndIconState>().selectedIcon.value;

                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.0,
                        ),
                    itemCount: AppIcons.availableIcons.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIcon == index;

                      return GestureDetector(
                        onTap: () =>
                            Get.find<SelectColorAndIconState>().pickIcon(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(50),
                            border: isSelected
                                ? Border.all(color: selectedColor, width: 3)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: selectedColor.withOpacity(0.3),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SvgPicture.asset(
                              AppIcons.getIconPath(index),
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              // BOTÓN GUARDAR - No necesita ser reactivo
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onSave(state.selectedColor.value, state.selectedIcon.value);
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
        );
      },
    );
  }
}
