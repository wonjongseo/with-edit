import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:with_diet/service/health_service.dart';
import 'package:with_diet/views/test.dart';

class EditHealthScreen extends StatefulWidget {
  const EditHealthScreen({super.key});

  @override
  State<EditHealthScreen> createState() => _EditHealthScreenState();
}

class _EditHealthScreenState extends State<EditHealthScreen> {
  List<double> healthValueByTime = List.filled(24, 0.0);

  HealthService healthService = HealthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchHealthData();
  }

  fetchHealthData() async {
    //await healthService.fetchHourlySteps();
    List<HealthDataPoint> healths = await healthService.fetchDataType(
      types: [HealthDataType.STEPS],
    );
    for (var health in healths) {
      if (health.value is NumericHealthValue) {
        healthValueByTime[health.dateFrom.hour] =
            (health.value as NumericHealthValue).numericValue.toDouble();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [Text('심장 및 혈액')]),

                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(healthValueByTime.length, (
                        index,
                      ) {
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              width: 15,
                              toY: healthValueByTime[index],
                            ),
                          ],
                        );
                      }),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return value % 6 == 0
                                  ? Text('${(value).toInt()}시')
                                  : SizedBox();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
