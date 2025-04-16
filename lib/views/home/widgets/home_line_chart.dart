import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:with_diet/controller/data_controller.dart';
import 'package:with_diet/core/enums/home_graph_type.dart';

class HomeLineChart extends StatefulWidget {
  const HomeLineChart({super.key});

  @override
  State<HomeLineChart> createState() => _HomeLineChartState();
}

class _HomeLineChartState extends State<HomeLineChart> {
  HomeGraphType selectedGraphType = HomeGraphType.step;
  List<FlSpot> stepGraph = [];

  List<FlSpot> caloryGraph = [];
  List<FlSpot> weightGraph = [];
  DataController dataController = Get.find<DataController>();

  List<FlSpot> getChartSpots(
    Map<String, HealthDayData> dataMap,
    HomeGraphType type,
  ) {
    final sortedKeys = dataMap.keys.toList()..sort(); // 날짜 정렬
    List<FlSpot> spots = [];
    for (int i = 0; i < sortedKeys.length; i++) {
      final day = sortedKeys[i];
      final data = dataMap[day]!;
      double y;
      switch (type) {
        case HomeGraphType.step:
          y = data.steps.toDouble();
          break;
        case HomeGraphType.calory:
          y = data.calories.toDouble();

          break;
        case HomeGraphType.weight:
          y = data.weight;
          break;
      }
      spots.add(y == 0 ? FlSpot.nullSpot : FlSpot(i.toDouble(), y));
    }
    return spots;
  }

  initGraph(Map<String, HealthDayData> dataMap) {
    stepGraph = getChartSpots(dataMap, HomeGraphType.step);
    caloryGraph = getChartSpots(dataMap, HomeGraphType.calory);
    weightGraph = getChartSpots(dataMap, HomeGraphType.weight);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
      builder: (dataConroller) {
        initGraph(dataController.healthDayDate);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DropdownButton2(
              value: selectedGraphType,
              underline: SizedBox(),
              onChanged: (v) {
                selectedGraphType = v!;
                setState(() {});
              },
              items: List.generate(HomeGraphType.values.length, (index) {
                HomeGraphType type = HomeGraphType.values[index];
                return DropdownMenuItem(value: type, child: Text(type.label));
              }),
            ),
            Container(
              padding: EdgeInsets.only(right: 22, left: 22, top: 8, bottom: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              height: 200,
              child: LineChart(
                duration: Duration.zero,
                LineChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final sortedKeys =
                              dataConroller.healthDayDate.keys.toList()..sort();
                          if (sortedKeys.isEmpty) return SizedBox();

                          final int index = value.toInt();
                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              DateFormat.Md().format(
                                DateTime.parse(sortedKeys[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    if (selectedGraphType == HomeGraphType.step)
                      LineChartBarData(
                        barWidth: 6,
                        color: Colors.greenAccent,
                        isCurved: true,
                        // dotData: FlDotData(show: nonZeroStepX < 2),
                        spots: stepGraph,
                      ),
                    if (selectedGraphType == HomeGraphType.weight)
                      LineChartBarData(
                        barWidth: 6,
                        color: Colors.blueAccent,
                        // dotData: FlDotData(show: nonZeroWeightX < 2),
                        isCurved: true,
                        spots: weightGraph,
                      ),
                    if (selectedGraphType == HomeGraphType.calory)
                      LineChartBarData(
                        barWidth: 6,
                        color: Colors.redAccent,
                        isCurved: true,
                        spots: caloryGraph,
                      ),
                  ],
                  minX: 0,
                  maxX: 29,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
