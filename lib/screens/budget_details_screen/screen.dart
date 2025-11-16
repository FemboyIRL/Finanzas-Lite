import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/navbar.dart';
import 'package:finanzas_lite/components/transactions_list.dart';
import 'package:finanzas_lite/models/budgets/budget_view_model.dart';
import 'package:finanzas_lite/screens/budget_details_screen/state.dart';
import 'package:finanzas_lite/utils/delegates/header_child_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class BudgetDetailsScreen extends StatelessWidget {
  final BudgetViewModel budget;
  const BudgetDetailsScreen({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BudgetDetailsState>(
      init: BudgetDetailsState(),
      builder: (state) => CommonScaffold(
        bottomNavigationBar: Navbar(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 50),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: HeaderChildSliverList(
                maxSize: 380,
                minSize: 380,
                child: Container(
                  color: const Color(0xFF141326),
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        _topRow(state, context),
                        _monthSelector(),
                        _totalBudget(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 30,
                          ),
                          child: Text(
                            "Todas las Transacciones",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          budget.transactions.isNotEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  sliver: TransactionsSliverList(
                    transactions: budget.transactions,
                  ),
                )
              : SliverToBoxAdapter(
                  child: SizedBox(
                    child: Center(
                      child: Text("Aún no has realizado transacciones..."),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Padding _totalBudget() {
    double total = 14500;
    double gasto = 12450.30;
    double progreso = gasto / total;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${budget.limit.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 28),
              ),
              Text("%19"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Stack(
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  height: 8,
                  width: progreso.clamp(0.0, 1.0) * 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6A66FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "-\$${budget.currentAmountSpent.toStringAsFixed(2)} gastado",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                "\$${(budget.limit - budget.currentAmountSpent).toStringAsFixed(2)} disponibles",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _monthSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 30),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.2), width: .5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5,
                  ),
                  child: Text("Noviembre"),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topRow(BudgetDetailsState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => state.onGoBack(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            budget.name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: budget.color,
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: GestureDetector(
              // onTap: () => Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const AddRecordScreen(),
              //   ),
              // ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(Icons.more_vert, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
