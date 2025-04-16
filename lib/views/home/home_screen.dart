import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:with_diet/controller/data_controller.dart';
import 'package:with_diet/core/admob/global_banner_admob.dart';
import 'package:with_diet/core/enums/food_health_data_type.dart';
import 'package:with_diet/core/enums/handle_day_type.dart';
import 'package:with_diet/core/enums/home_graph_type.dart';

import 'package:with_diet/service/health_service.dart';
import 'package:with_diet/views/edit_health/edit_health_screen.dart';
import 'package:with_diet/views/edit_health_data/edit_health_data_controller.dart';
import 'package:with_diet/views/edit_health_data/edit_health_data_screen.dart';
import 'package:with_diet/views/health_history/health_history_screen.dart';
import 'package:with_diet/views/home/widgets/home_line_chart.dart';
import 'package:with_diet/views/home/widgets/home_list_tile.dart';

class DailyHealthData {
  final DateTime date;
  final int steps;
  final double weight;
  final int calories;

  DailyHealthData({
    required this.date,
    required this.steps,
    required this.weight,
    required this.calories,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // fetchHealthData() async {
  //   // dataController.aa();
  //   return;
  //   var res = await healthService.fetchDataByType([
  //     HealthDataType.WEIGHT,
  //     HealthDataType.DIETARY_PROTEIN_CONSUMED,
  //     HealthDataType.DIETARY_FATS_CONSUMED,
  //     HealthDataType.DIETARY_CARBS_CONSUMED,
  //   ]);
  //   for (var re in res) {
  //     double value = (re.value as NumericHealthValue).numericValue.toDouble();
  //     if (re.type == HealthDataType.WEIGHT) {
  //       weight = value;
  //     } else if (foodHealthDataType.contains(re.type)) {
  //       totalKcal += value;
  //     } else {
  //       print('ELSE, ${re.type} :  ${re.value}');
  //     }
  //   }

  //   // healthService.fetchStepData();
  //   return;
  //   var data = await healthService.fetchAndStoreHealthData(
  //     "OPOhhHNqdtMutHfIht1ydeau67r1",
  //   );
  //   var a =
  //       data['2025-04-14']!['steps'].values.map((e) {
  //         return e;
  //       }).toList();
  //   print('a : ${a}');

  //   return;
  //   List<HealthDataPoint> healths = await healthService.fetchDataType(
  //     types: [HealthDataType.STEPS, HealthDataType.WEIGHT],
  //   );
  //   for (var health in healths) {
  //     if (health.value is NumericHealthValue) {
  //       healthValueByTime[health.dateFrom.hour] =
  //           (health.value as NumericHealthValue).numericValue.toDouble();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(DataController());

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalBannerAdmob(),
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(label: 'add', icon: Icon(Icons.add)),
              BottomNavigationBarItem(
                label: 'delete',
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
          child: GetBuilder<DataController>(
            builder: (dataController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '함께 다이어트',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(
                                () => EditHealthDataScreen(),
                                binding: BindingsBuilder.put(
                                  () => EditHealthDataController(),
                                ),
                              );
                            },
                            icon: Icon(FontAwesomeIcons.add),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.user),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          dataController.handleDay(HandleDayType.back);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          dataController.handleDay(HandleDayType.today);
                        },
                        child: Text(
                          DateFormat.yMEd(
                            Get.locale.toString(),
                          ).format(dataController.selectedDay),
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          dataController.handleDay(HandleDayType.go);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: GetBuilder<DataController>(
                      builder: (dataController) {
                        return Column(
                          children: [
                            HomeListTile(
                              onTap: () {
                                Get.to(
                                  () => HealthHistoryScreen(
                                    type: HomeGraphType.step,
                                    dateTime: dataController.selectedDay,
                                  ),
                                );
                              },
                              title: "걸음 수",
                              todayValue:
                                  dataController.currentHealthDate?.steps,
                              yesterDayValue:
                                  dataController.yesterdayHealthDate?.steps,
                              sufficText: '보',
                              icon: FontAwesomeIcons.running,
                              containerColor: Colors.greenAccent,
                            ),
                            SizedBox(height: 10),
                            HomeListTile(
                              onTap: () {
                                Get.to(
                                  () => HealthHistoryScreen(
                                    type: HomeGraphType.calory,
                                    dateTime: dataController.selectedDay,
                                  ),
                                );
                              },
                              title: "섭취 칼로리",

                              todayValue:
                                  dataController.currentHealthDate?.calories
                                      .toInt(),
                              yesterDayValue:
                                  dataController.yesterdayHealthDate?.calories
                                      .toInt(),
                              sufficText: 'kcal',
                              icon: FontAwesomeIcons.bowlRice,
                              containerColor: Colors.redAccent,
                            ),
                            SizedBox(height: 10),
                            HomeListTile(
                              onTap: () {
                                Get.to(
                                  () => HealthHistoryScreen(
                                    type: HomeGraphType.weight,
                                    dateTime: dataController.selectedDay,
                                  ),
                                );
                              },
                              title: "몸무게",
                              todayValue:
                                  dataController.currentHealthDate?.weight
                                      .toInt(),
                              yesterDayValue:
                                  dataController.yesterdayHealthDate?.weight
                                      .toInt(),
                              sufficText: 'kg',
                              icon: FontAwesomeIcons.weight,
                              containerColor: Colors.blueAccent,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 4),
                  HomeLineChart(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


// 14.0+1157.0+1870.0+2249.0+526.0+469.0+794.0+414.0+613.0+771.0+646.0+2127.0+2866.0