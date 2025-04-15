import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';

import 'package:with_diet/service/health_service.dart';
import 'package:with_diet/views/edit_health/edit_health_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HealthService healthService = HealthService();
  List<double> healthValueByTime = List.filled(24, 0.0);

  @override
  void initState() {
    fetchHealthData();
    super.initState();
  }

  fetchHealthData() async {
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
    return 1 == 1
        ? Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 70,
                color: Colors.grey,
                child: Center(child: Text('AD MOB')),
              ),
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
                          title: "걸음 수",
                          plus: "1,204보",
                          count: '7,520보',
                          icon: FontAwesomeIcons.running,
                          containerColor: Colors.greenAccent,
                        ),
                        SizedBox(height: 10),
                        HomeListTile(
                          title: "섭취 칼로리",
                          plus: "목표 : 2000kcal",
                          count: '1.850kcal',
                          icon: FontAwesomeIcons.bowlRice,
                          containerColor: Colors.redAccent,
                        ),
                        SizedBox(height: 10),
                        HomeListTile(
                          title: "몸무게",
                          plus: "-0.3kg",
                          count: '65.2kg',
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
        )
        : _test(healthService);
  }

  Scaffold _test(HealthService dataController) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EditHealthScreen());
            },
            icon: Icon(FontAwesomeIcons.user),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home'),
              TextButton(
                onPressed: () {
                  dataController.getHealthConnectSdkStatus();
                },
                child: Text("getHealthConnectSdkStatus"),
              ),
              TextButton(
                onPressed: () {
                  dataController.authorize();
                },
                child: Text("authorize"),
              ),
              TextButton(
                onPressed: () {
                  dataController.fetchData();
                },
                child: Text("fetchData"),
              ),
              TextButton(
                onPressed: () {
                  dataController.fetchStepData();
                },
                child: Text("fetchStepData"),
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
    Key? key,
    required this.title,
    required this.plus,
    required this.count,
    required this.containerColor,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String plus;
  final String count;
  final Color containerColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
