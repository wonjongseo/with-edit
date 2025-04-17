import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:with_diet/core/enums/handle_day_type.dart';

import 'package:with_diet/service/health_service.dart';
import 'package:with_diet/views/test.dart';

class HealthDayData {
  final String date; // yyyy-MM-dd
  final int steps;
  final double weight;
  final double calories;

  HealthDayData({
    required this.date,
    required this.steps,
    required this.weight,
    required this.calories,
  });

  Map<String, dynamic> toMap() {
    return {'steps': steps, 'weight': weight, 'calories': calories};
  }

  @override
  String toString() {
    return 'HealthDayData(date: $date, steps: $steps, weight: $weight, calories: $calories)';
  }

  HealthDayData copyWith({
    String? date,
    int? steps,
    double? weight,
    double? calories,
  }) {
    return HealthDayData(
      date: date ?? this.date,
      steps: steps ?? this.steps,
      weight: weight ?? this.weight,
      calories: calories ?? this.calories,
    );
  }
}

class DataController extends GetxController {
  HealthService healthService = HealthService();
  Map<String, HealthDayData> healthDayDate = {};

  HealthDayData? currentHealthDate;
  HealthDayData? yesterdayHealthDate;
  DateTime selectedDay = DateTime.now();

  void handleDay(HandleDayType type) {
    switch (type) {
      case HandleDayType.go:
        selectedDay = selectedDay.add(Duration(days: 1));
      case HandleDayType.back:
        selectedDay = selectedDay.subtract(Duration(days: 1));
      case HandleDayType.today:
        selectedDay = DateTime.now();
    }

    getTodayAndYesterHealthData();
    update();
  }

  @override
  void onInit() {
    loadHealthData();

    super.onInit();
  }

  void getTodayAndYesterHealthData() {
    currentHealthDate =
        healthDayDate[DateFormat('yyyy-MM-dd').format(selectedDay)];
    yesterdayHealthDate =
        healthDayDate[DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDay.subtract(Duration(days: 1)))];
  }

  Future<void> loadHealthData() async {
    healthDayDate = await healthService.fetchAndStoreMonthlyHealthData('');

    getTodayAndYesterHealthData();
    update();
  }

  Future<void> deleteaa(HealthDataPoint healthDataPoint) async {
    await healthService.deleteByUuid(healthDataPoint);
    await loadHealthData();
  }
}
