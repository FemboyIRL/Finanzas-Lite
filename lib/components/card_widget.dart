import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatelessWidget {
  final AccountViewModel account;
  const CardWidget({super.key, required this.account});

  // Función para generar colores aleatorios fuertes (saturación alta).
  Color _randomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      100 + random.nextInt(155), // evitar colores muy oscuros
      100 + random.nextInt(155),
      100 + random.nextInt(155),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color1 = _randomColor();
    final color2 = _randomColor();

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Línea superior con chip y SVG
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20),
            child: Row(
              children: [
                Image.asset('assets/images/Chip.png', height: 50, width: 50),
                SizedBox(width: 20),
                SvgPicture.asset(
                  "assets/svgs/card.svg",
                  height: 55,
                  width: 55,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          // Número y fecha
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "**** **** **** ${account.lastFourNumbers}",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white70,
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                account.expirationDate,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ],
          ),

          Text(
            account.owner,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
