import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:with_diet/core/admob/global_banner_admob.dart';
import 'package:with_diet/core/enums/food_health_data_type.dart';

import 'package:with_diet/service/health_service.dart';
import 'package:with_diet/views/edit_health/edit_health_screen.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HealthService healthService = HealthService();
  List<double> healthValueByTime = List.filled(24, 0.0);

  /**\
   
   한달 동안의 걸음수를 하루 씩 확인할 수 있게 ,
   한달 동안의 몸무게를 하루 씩 확인할 수 있게,
   한달 동안의 칼로리를 하루 씩 확인할 수 있게
   */

  @override
  void initState() {
    fetchHealthData();
    super.initState();
  }

  double totalKcal = 0.0;
  double weight = 0.0;
  double steps = 0.0;

  fetchHealthData() async {
    var res = await healthService.fetchDataByType([
      HealthDataType.WEIGHT,
      HealthDataType.DIETARY_PROTEIN_CONSUMED,
      HealthDataType.DIETARY_FATS_CONSUMED,
      HealthDataType.DIETARY_CARBS_CONSUMED,
    ]);
    for (var re in res) {
      double value = (re.value as NumericHealthValue).numericValue.toDouble();
      if (re.type == HealthDataType.WEIGHT) {
        weight = value;
      } else if (foodHealthDataType.contains(re.type)) {
        totalKcal += value;
      } else {
        print('ELSE, ${re.type} :  ${re.value}');
      }
    }
    setState(() {});

    // healthService.fetchStepData();
    return;
    var data = await healthService.fetchAndStoreHealthData(
      "OPOhhHNqdtMutHfIht1ydeau67r1",
    );
    var a =
        data['2025-04-14']!['steps'].values.map((e) {
          return e;
        }).toList();
    print('a : ${a}');

    return;
    List<HealthDataPoint> healths = await healthService.fetchDataType(
      types: [HealthDataType.STEPS, HealthDataType.WEIGHT],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchHealthData();
        },
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                        onPressed: () {},
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2025년 4월 13일 (일)',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Icon(FontAwesomeIcons.calendar, color: Colors.grey),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    HomeListTile(
                      onTap: () {},
                      title: "걸음 수",
                      plus: "1,204보",
                      count: '7,520보',
                      icon: FontAwesomeIcons.running,
                      containerColor: Colors.greenAccent,
                    ),
                    SizedBox(height: 10),
                    HomeListTile(
                      onTap: () {
                        Get.dialog(AlertDialog(content: AddHealthDataWidet()));
                      },
                      title: "섭취 칼로리",
                      plus: "목표 : 2000kcal",
                      count: '${totalKcal} kcal',
                      icon: FontAwesomeIcons.bowlRice,
                      containerColor: Colors.redAccent,
                    ),
                    SizedBox(height: 10),
                    HomeListTile(
                      onTap: () {},
                      title: "몸무게",
                      plus: "-0.3kg",
                      count: '${weight} kg',
                      icon: FontAwesomeIcons.weight,
                      containerColor: Colors.blueAccent,
                    ),

                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: BarChart(BarChartData()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeListTile extends StatelessWidget {
  const HomeListTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.plus,
    required this.count,
    required this.containerColor,
    required this.icon,
  });
  final Function() onTap;
  final String title;
  final String plus;
  final String count;
  final Color containerColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: containerColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: containerColor),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 2),
                Text('+$plus'),
              ],
            ),
            Spacer(),
            Text(
              count,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}


// 14.0+1157.0+1870.0+2249.0+526.0+469.0+794.0+414.0+613.0+771.0+646.0+2127.0+2866.0