import 'package:finanzas_lite/components/transaction_widget.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsSliverList extends StatelessWidget {
  final List<TransactionViewModel> transactions;

  const TransactionsSliverList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Agrupar las transacciones por fecha (ignorando la hora)
    final groupedTransactions = <String, List<TransactionViewModel>>{};
    for (final transaction in transactions) {
      final dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
      groupedTransactions.putIfAbsent(dateKey, () => []).add(transaction);
    }

    // Ordenar las fechas (más recientes primero)
    final sortedKeys = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, groupIndex) {
        final dateKey = sortedKeys[groupIndex];
        final formattedDate = DateFormat(
          'dd MMM yyyy',
        ).format(DateTime.parse(dateKey));
        final dayTransactions = groupedTransactions[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado de fecha
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 8, top: 12),
              child: Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),

            // Lista de transacciones de ese día
            ...dayTransactions.map(
              (transaction) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                child: TransactionWidget(transaction: transaction),
              ),
            ),
          ],
        );
      }, childCount: sortedKeys.length),
    );
  }
}
