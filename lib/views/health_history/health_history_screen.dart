import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:health/health.dart';
import 'package:with_diet/core/admob/global_banner_admob.dart';

import 'package:with_diet/core/enums/home_graph_type.dart';
import 'package:with_diet/core/widgets/custom_button.dart';
import 'package:with_diet/service/health_service.dart';
import 'package:with_diet/views/edit_health_data/edit_health_data_controller.dart';
import 'package:with_diet/views/edit_health_data/edit_health_data_screen.dart';
import 'package:with_diet/views/health_history/widgets/task_tile.dart';

class HealthHistoryScreen extends StatefulWidget {
  const HealthHistoryScreen({
    super.key,
    required this.type,
    required this.dateTime,
  });

  final HomeGraphType type;
  final DateTime dateTime;
  @override
  State<HealthHistoryScreen> createState() => _HealthHistoryScreenState();
}

class _HealthHistoryScreenState extends State<HealthHistoryScreen> {
  HealthService _healthService = HealthService();
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    print('widget.dateTime : ${widget.dateTime}');

    dateTime = widget.dateTime;
    getHeal();
  }

  List<HealthDataPoint> _healthDataPoints = [];
  List<HealthDataPoint> filterdHealthDataPoints = [];
  filter() {
    filterdHealthDataPoints =
        _healthDataPoints
            .where(
              (healthDataPoint) =>
                  (healthDataPoint.dateFrom.year == dateTime.year &&
                      healthDataPoint.dateFrom.month == dateTime.month &&
                      healthDataPoint.dateFrom.day == dateTime.day),
            )
            .toList();
  }

  getHeal() async {
    _healthDataPoints = await _healthService.fetchDataType(
      types: widget.type.healthDataTypes,
    );
    filter();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.type.label)),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlobalBannerAdmob(),
            SizedBox(height: 8),
            CustomButton(
              label: '등록',
              onTap: () {
                Get.to(
                  () => EditHealthDataScreen(),
                  binding: BindingsBuilder.put(
                    () => EditHealthDataController(
                      type: widget.type,
                      date: dateTime,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            DatePicker(
              dateTime.subtract(Duration(days: 1)),
              initialSelectedDate: dateTime,
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                dateTime = date;
                filter();
                setState(() {});
              },
            ),
            SizedBox(height: 20),

            Expanded(child: _listView()),
          ],
        ),
      ),
    );
  }

  ListView _listView() {
    return ListView.builder(
      itemCount: filterdHealthDataPoints.length,
      itemBuilder: (_, index) {
        HealthDataPoint p = filterdHealthDataPoints[index];
        if (p.value is AudiogramHealthValue) {
          return ListTile(
            title: Text("1 ${p.typeString}: ${p.value}"),
            trailing: Text(p.unitString),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
          );
        }
        if (p.value is WorkoutHealthValue) {
          return ListTile(
            title: Text(
              "2. ${p.typeString}: ${(p.value as WorkoutHealthValue).totalEnergyBurned} ${(p.value as WorkoutHealthValue).totalEnergyBurnedUnit?.name}",
            ),
            trailing: Text(
              (p.value as WorkoutHealthValue).workoutActivityType.name,
            ),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
          );
        }
        if (p.value is NutritionHealthValue) {
          return ListTile(
            title: Text(
              "3. ${p.typeString} ${(p.value as NutritionHealthValue).mealType}: ${(p.value as NutritionHealthValue).name}",
            ),
            trailing: Text(
              '${(p.value as NutritionHealthValue).calories} kcal',
            ),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
          );
        }

        return TaskTile(healthDataPoint: p);
        // return Column(
        //   children: [
        //     Text(p.sourceDeviceId),
        //     Text(p.sourceId),
        //     Text(p.typeString),
        //     Text(p.unitString.toLowerCase()),
        //     Text(p.uuid),
        //     Text(p.metadata?.toString() ?? ""),
        //     Text(p.recordingMethod.toString()),
        //     Text(p.sourcePlatform.toString()),
        //   ],
        // );
        return ListTile(
          title: Text("4. ${p.typeString}: ${p.value}"),
          trailing: Text(p.unitString),
          subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
        );
      },
    );
  }
}
