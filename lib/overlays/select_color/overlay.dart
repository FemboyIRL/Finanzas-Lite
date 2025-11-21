import 'package:finanzas_lite/components/overlay.dart';
import 'package:finanzas_lite/overlays/select_color/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SelectColorOverlay extends StatelessWidget {
  final Function(Color) onSave;

  const SelectColorOverlay({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectColorState>(
      init: SelectColorState(),
      builder: (state) => FullScreenOverlay(
        title: "Seleccionar Color",
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // Grid de colores
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 4 columnas
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                    itemCount: state.availableColors.length,
                    itemBuilder: (context, index) {
                      final color = state.availableColors[index];
                      return GestureDetector(
                        onTap: () => state.pickColor(color),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border:
                                  state.selectedColor.value.value == color.value
                                  ? Border.all(color: Colors.white, width: 3.0)
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child:
                                state.selectedColor.value.value == color.value
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 24.0,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Botón de guardar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      onSave(state.selectedColor.value);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.selectedColor.value,
                      foregroundColor: _getTextColor(state.selectedColor.value),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      "Seleccionar Color",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para determinar el color del texto según el fondo
  Color _getTextColor(Color backgroundColor) {
    // Calcula el brillo del color de fondo
    final brightness = backgroundColor.computeLuminance();
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
}
