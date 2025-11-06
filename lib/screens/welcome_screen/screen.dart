import 'package:finanzas_lite/screens/welcome_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeState>(
      init: WelcomeState(),
      builder: (state) => Scaffold(
        body: Stack(
          children: [
            // Fondo base
            Container(color: const Color(0xFF141326)),

            // Elipse difuminada inferior derecha
            Positioned(
              bottom: -250,
              right: -125,
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0x80E840D1), // semitransparente
                      Colors.transparent,
                    ],
                    radius: 0.6,
                  ),
                ),
              ),
            ),

            // Contenido principal
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: state.pageController,
                      onPageChanged: state.updatePage,
                      itemCount: state.steps.length,
                      itemBuilder: (context, index) {
                        final step = state.steps[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 100,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Imagen SVG
                              Image.asset(
                                step.icon,
                                height: 220,
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 60),

                              // Indicadores
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(state.steps.length, (
                                    i,
                                  ) {
                                    final isActive =
                                        state.currentPage.value == i;
                                    return AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      width: isActive ? 20 : 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? Color(0xFF006C52)
                                            : Colors.grey.shade700,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Texto
                              Text(
                                step.text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botón inferior - CORREGIDO
                  Obx(() {
                    final isLast =
                        state.currentPage.value == state.steps.length - 1;
                    final isFirst = state.currentPage.value == 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          // Botón Anterior (solo texto, sin borde)
                          if (!isFirst)
                            Expanded(
                              child: TextButton(
                                onPressed: state.previousPage,
                                child: const Text(
                                  "< Anterior",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                          if (!isFirst) const SizedBox(width: 12),

                          // Botón Siguiente/Comenzar
                          Expanded(
                            child: ElevatedButton(
                              onPressed: state.nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF006C52),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                isLast ? "Comenzar" : "Siguiente >",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
