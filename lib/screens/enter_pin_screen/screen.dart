import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/numeric_keyboard.dart';
import 'package:finanzas_lite/screens/enter_pin_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class EnterPinScreen extends StatelessWidget {
  const EnterPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnterPinState>(
      init: EnterPinState(),
      builder: (state) => CommonScaffold(
        showTopEllipsis: false,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header y PIN
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Ingresa tu PIN",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Indicador visual del PIN
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50.0),
                          child: Obx(() {
                            final length = state.inputText.value.length;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index < length
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.3),
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  // Teclado numérico
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: NumericKeyboard(
                      onKeyPressed: (value) => state.onKeyPressed(value),
                      onBackspacePressed: () => state.onBackspacePressed(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
