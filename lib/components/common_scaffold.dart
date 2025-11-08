import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const CommonScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
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

          Positioned(
            top: -280,
            right: 50,
            child: Container(
              width: 500,
              height: 450,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x80E840D1), // semitransparente
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Contenido principal
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            child: body,
          ),
        ],
      ),
    );
  }
}
