import 'package:finanzas_lite/components/category_info_card.dart';
import 'package:finanzas_lite/components/common_scaffold.dart';
import 'package:finanzas_lite/components/navbar.dart';
import 'package:finanzas_lite/components/statistics_info_bar.dart';
import 'package:finanzas_lite/models/categories/category_view_model.dart';
import 'package:finanzas_lite/screens/stats_screen/state.dart';
import 'package:finanzas_lite/utils/custom_doughnut_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsState>(
      init: StatisticsState(),
      builder: (state) => CommonScaffold(
        bottomNavigationBar: Navbar(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _topRow(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: _categoriesCard(state, context),
                ),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 350,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.categories.length,
                        itemBuilder: (_, index) {
                          return StatisticsInfoBar(
                            category: state.categories[index],
                            total: state.total,
                          );
                        },
                      ),
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

  Widget _topRow() {
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

  SizedBox _categoriesCard(StatisticsState state, BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
}
