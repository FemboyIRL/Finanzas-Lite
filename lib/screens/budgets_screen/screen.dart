import 'package:finanzas_lite/components/budget_card.dart';
import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/navbar.dart';
import 'package:finanzas_lite/screens/budgets_screen/state.dart';
import 'package:finanzas_lite/utils/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BudgetsState>(
      init: BudgetsState(),
      builder: (state) => CommonScaffold(
        bottomNavigationBar: Navbar(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _topRow(state, context),
                _totalBudget(state),

                state.budgets.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: SizedBox(
                          height: 500,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: state.budgets.length,
                            itemBuilder: (context, index) {
                              final transaction = state.budgets[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: BudgetCard(budget: transaction),
                              );
                            },
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 50,
                        ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Registra tu primer presupuesto para empezar a ahorrar",
                          ),
                        ),
                      ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Padding _totalBudget(BudgetsState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.2), width: .5),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Text(
                "Presupuesto Total",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${state.balance}\$", style: TextStyle(fontSize: 28)),
                Text("${state.percentSpent.toStringAsFixed(0)}%"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: ProgressBar(
                limit: state.balance,
                spent: state.totalSpent,
                color: Colors.deepPurpleAccent,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "-${state.totalSpent}\$ gastado",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "${state.totalRemaining}\$ disponibles",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _topRow(BudgetsState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
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
                const SizedBox(width: 10),
                const Text(
                  "Presupuestos",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () => state.onTapNewBudget(context),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6A66FF), Color(0xFF8B86FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6A66FF).withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.add, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
