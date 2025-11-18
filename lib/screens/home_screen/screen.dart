import 'package:finanzas_lite/components/budget_info_card.dart';
import 'package:finanzas_lite/components/category_info_card.dart';
import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/navbar.dart';
import 'package:finanzas_lite/components/transaction_widget.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/screens/home_screen/state.dart';
import 'package:finanzas_lite/utils/custom_doughnut_chart.dart';
import 'package:finanzas_lite/utils/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeState>(
      init: HomeState(),
      builder: (state) => CommonScaffold(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _topRow(),
                const SizedBox(height: 15),
                _totalBalanceCard(),
                const SizedBox(height: 15),
                _budgetCard(state, context),
                const SizedBox(height: 15),
                _categoriesCard(state, context),
                const SizedBox(height: 15),
                _lastTransactions(state, context),
              ]),
            ),
          ),
        ],
        bottomNavigationBar: Navbar(),
      ),
    );
  }

  Row _topRow() {
    return Row(
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text("31 AGO 2025"),
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
            child: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }

  SizedBox _lastTransactions(HomeState state, BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Center(
            child: Text(
              "Últimas Transacciones",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          state.transactions.isNotEmpty
              ? SizedBox(
                  height: 250,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.vertical,
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = state.transactions[index];
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: TransactionWidget(transaction: transaction),
                      );
                    },
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text("No has registrado transacciones aún"),
                ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => state.onTapAllTransactions(context),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color(0x806A66FF).withOpacity(0.2),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
              ),
              child: const Text(
                "Todas las transacciones",
                style: TextStyle(fontSize: 14, color: Color(0xFF6A66FF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _categoriesCard(HomeState state, BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con título y botón
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categorías",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => state.onTapAllStats(context),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0x806A66FF).withOpacity(0.2),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                    ),
                    child: const Text(
                      "Estadísticas",
                      style: TextStyle(fontSize: 14, color: Color(0xFF6A66FF)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- Doughnut chart ---
              Center(
                child: SizedBox(
                  height: 180,
                  width: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SfCircularChart(
                        series: <DoughnutSeries<CategoryViewModel, String>>[
                          CustomDoughnutSeries<CategoryViewModel, String>(
                            dataSource: state.categories,
                            xValueMapper: (CategoryViewModel data, _) =>
                                data.name,
                            yValueMapper: (CategoryViewModel data, _) =>
                                data.currentAmountSpent,
                            pointColorMapper: (CategoryViewModel data, _) =>
                                data.color,
                            innerRadius: '70%',
                            radius: '100%',
                            gap: "3.0",
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Gastos",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "${state.total.toStringAsFixed(2)}\$",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox.square(dimension: 20),

              SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 12),
                      child: CategoryInfoCard(category: category),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _budgetCard(HomeState state, BuildContext context) {
    //TODO: Pasar estos valores al estado
    // valores de prueba
    double total = 14500;
    double gasto = 12450.30;

    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texto
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Presupuestos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => state.onTapAllBudgets(context),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0x806A66FF).withOpacity(0.2),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                    ),
                    child: const Text(
                      "Todos",
                      style: TextStyle(fontSize: 14, color: Color(0xFF6A66FF)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Text("14,500.00\$", style: TextStyle(fontSize: 25)),
                  Text(" restantes", style: TextStyle(fontSize: 15)),
                ],
              ),
              const Text(
                "- \$12,450.30 gastados este mes",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),

              // Barra de gastos vs restante
              ProgressBar(
                limit: total,
                spent: gasto,
                color: Colors.deepPurpleAccent,
              ),
              Divider(height: 30, color: Colors.grey.withOpacity(0.3)),

              SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.budgets.length,
                  itemBuilder: (context, index) {
                    final budget = state.budgets[index];
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 12),
                      child: BudgetInfoCard(budget: budget),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _totalBalanceCard() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Balance Total",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              Text("26,000.00\$", style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }
}
