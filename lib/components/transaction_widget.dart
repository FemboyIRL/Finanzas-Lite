import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:finanzas_lite/screens/record_detail_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionViewModel transaction;

  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecordDetailsScreen(transaction: transaction),
        ),
      ),
      child: Padding(
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
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: transaction.mainColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                  ),
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

            // Monto y fecha
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
      ),
    );
  }
}
