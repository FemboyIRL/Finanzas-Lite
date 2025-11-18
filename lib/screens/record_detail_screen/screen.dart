import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/navbar.dart';
import 'package:finanzas_lite/models/accounts/view_model.dart';
import 'package:finanzas_lite/models/transactions/transactions_view_model.dart';
import 'package:finanzas_lite/screens/record_detail_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RecordDetailsScreen extends StatelessWidget {
  final TransactionViewModel transaction;
  const RecordDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordDetailsState>(
      init: RecordDetailsState(),
      builder: (state) => CommonScaffold(
        bottomNavigationBar: Navbar(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _topRow(state, context),
                _transactionTypeView(),
                _transactionAmountView(),
                _buildDetailItem(
                  "Cuenta",
                  transaction.account.name,
                  transaction.account.type.icon,
                ),
                _buildDetailItem(
                  "Categoría",
                  transaction.category.name,
                  transaction.category.icon,
                ),
                _buildDetailItem(
                  "Fecha & Hora",
                  "${transaction.date.day.toString().padLeft(2, '0')}/"
                      "${transaction.date.month.toString().padLeft(2, '0')}/"
                      "${transaction.date.year} ${transaction.date.hour}: ${transaction.date.minute}",
                  "assets/svgs/icon_calendar.svg",
                ),
                _notesView(),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => state.onTapDelete(),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.red.withOpacity(0.2),
                            ),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 15),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(15),
                              ),
                            ),
                          ),

                          child: Text(
                            "Eliminar",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => state.onTapSave(),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Color(0xFF6A66FF).withOpacity(0.2),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 15),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                          ),
                        ),

                        child: Text(
                          "Guardar",
                          style: TextStyle(color: Color(0xFF6A66FF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Padding _notesView() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Notas", style: TextStyle(color: Colors.grey)),
          Text(transaction.description, style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }

  Padding _transactionAmountView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(transaction.type.name, style: TextStyle(color: Colors.grey)),
          Text(
            '${transaction.amount.toStringAsFixed(2)}\$',
            style: TextStyle(fontSize: 50, color: transaction.type.color),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String subTitle, String icon) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.symmetric(
          horizontal: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey)),
                Text(subTitle, style: TextStyle(fontSize: 17)),
              ],
            ),

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  icon,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _transactionTypeView() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        children: [
          // Gasto (rojo)
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: transaction.type == TransactionType.expense
                        ? Colors.red
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "Gasto",
                style: TextStyle(
                  color: transaction.type == TransactionType.expense
                      ? Colors.red
                      : Colors.white,
                ),
              ),
            ),
          ),

          // Ingreso (verde)
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: transaction.type == TransactionType.income
                        ? Colors.green
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "Ingreso",
                style: TextStyle(
                  color: transaction.type == TransactionType.income
                      ? Colors.green
                      : Colors.white,
                ),
              ),
            ),
          ),

          // Transferencia (naranja)
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: transaction.type == TransactionType.transfer
                        ? Colors.orange
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "Transferencia",
                style: TextStyle(
                  color: transaction.type == TransactionType.transfer
                      ? Colors.orange
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _topRow(RecordDetailsState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Detalles Transacción", style: TextStyle(fontSize: 20)),
        GestureDetector(
          onTap: () => state.onGoBack(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
