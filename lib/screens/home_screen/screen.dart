import 'package:finanzas_lite/components/budget_info_card.dart';
import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/screens/home_screen/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeState>(
      init: HomeState(),
      builder: (state) => CommonScaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _totalBalanceCard(),
              SizedBox.square(dimension: 20),
              _budgetCard(state),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _budgetCard(HomeState state) {
    // valores de prueba
    double total = 14500;
    double gasto = 12450.30;
    double progreso = gasto / total; // porcentaje gastado

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
                    onPressed: () {},
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
                  Text("\$14,500.00", style: TextStyle(fontSize: 25)),
                  Text(" restantes", style: TextStyle(fontSize: 15)),
                ],
              ),
              const Text(
                "- \$12,450.30 gastados este mes",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),

              // Barra de gastos vs restante
              Stack(
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

              Divider(height: 30, color: Colors.grey.withOpacity(0.3)),

              SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.budgets.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
              Text("\$26,000.00", style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }
}
