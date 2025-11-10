import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionViewModel {
  final List<String> categoriesName;
  final Color mainColor;
  final List<String> acountNames;
  final String icon;
  final DateTime date;
  final double amount;
  final bool isActive = false;
  void Function(void) onDelete;

  TransactionViewModel({
    required this.acountNames,
    required this.mainColor,
    required this.icon,
    required this.amount,
    required this.categoriesName,
    required this.date,
    required this.onDelete,
  });
}

class TransactionWidget extends StatelessWidget {
  final TransactionViewModel transaction;

  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Círculo de fondo con opacidad
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: transaction.mainColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
                // Ícono sin opacidad
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    transaction.icon,
                    colorFilter: ColorFilter.mode(
                      HSLColor.fromColor(
                        transaction.mainColor,
                      ).withSaturation(1).withLightness(0.5).toColor(),
                      BlendMode.srcATop,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Nombre de categoría y cuenta
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.categoriesName.first,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  transaction.acountNames.first,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Monto y fecha a la derecha
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: transaction.amount >= 0
                      ? const Color(0xFF00FF85)
                      : Colors.redAccent,
                ),
              ),
              Text(
                "${transaction.date.day.toString().padLeft(2, '0')}/"
                "${transaction.date.month.toString().padLeft(2, '0')}/"
                "${transaction.date.year}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
