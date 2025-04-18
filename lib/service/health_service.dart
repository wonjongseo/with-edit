import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:with_diet/controller/data_controller.dart';
import 'package:with_diet/core/health/health_data_type.dart';

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_DELETED,
  DATA_NOT_ADDED,
  DATA_NOT_DELETED,
  STEPS_READY,
  HEALTH_CONNECT_STATUS,
  PERMISSIONS_REVOKING,
  PERMISSIONS_REVOKED,
  PERMISSIONS_NOT_REVOKED,
}

class HealthService {
  final health = Health();
  List<HealthDataPoint> _healthDataList = [];
  List<RecordingMethod> recordingMethodsToFilter = [];

  Future<void> deleteByUuid(HealthDataPoint healthDataPoint) async {
    try {
      print('healthDataPoint.uuid : ${healthDataPoint.uuid}');

      bool result = await health.deleteByUUID(
        uuid: healthDataPoint.uuid,
        type: healthDataPoint.type,
      );
      print('result : ${result}');
    } catch (e) {
      print('e.toString : ${e.toString()}');
    }
  }

  Future<Map<DateTime, int>> fetchHourlySteps() async {
    final types = [HealthDataType.STEPS];

    Map<DateTime, int> hourlySteps = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 0);

    final yesterday = now.add(const Duration(hours: 24));
    final rawData = await health.getHealthDataFromTypes(
      types: types,
      startTime: today,
      endTime: yesterday,
      recordingMethodsToFilter: recordingMethodsToFilter,
    );

    for (var data in rawData) {
      if (data.type == HealthDataType.STEPS) {
        final hourKey = DateTime(
          data.dateFrom.year,
          data.dateFrom.month,
          data.dateFrom.day,
          data.dateFrom.hour,
        );

        hourlySteps.update(
          hourKey,
          (value) => value + (data.value as int),
          ifAbsent: () => (data.value as int),
        );
      }
    }

    return hourlySteps;
  }

  Future<void> addDataByType({
    required HealthDataType type,
    required double value,
    required DateTime date,
  }) async {
    try {
      final earlier = date.subtract(const Duration(minutes: 1));
      await health.writeHealthData(
        value: value,
        type: type,
        startTime: earlier,
        endTime: date,
        recordingMethod: RecordingMethod.manual,
      );
    } catch (e) {
      print('e.toString() : ${e.toString()}');
    }
  }

  Future<void> addData() async {
    final now = DateTime.now();
    final earlier = now.subtract(const Duration(minutes: 20));

    bool success = true;

    success &= await health.writeHealthData(
      value: 1.925,
      type: HealthDataType.HEIGHT,
      startTime: earlier,
      endTime: now,
      recordingMethod: RecordingMethod.manual,
    );
    success &= await health.writeHealthData(
      value: 90,
      type: HealthDataType.WEIGHT,
      startTime: now,
      recordingMethod: RecordingMethod.manual,
    );
    success &= await health.writeHealthData(
      value: 90,
      type: HealthDataType.HEART_RATE,
      startTime: earlier,
      endTime: now,
      recordingMethod: RecordingMethod.manual,
    );
    success &= await health.writeHealthData(
      value: 90,
      type: HealthDataType.STEPS,
      startTime: earlier,
      endTime: now,
      recordingMethod: RecordingMethod.manual,
    );
    success &= await health.writeHealthData(
      value: 200,
      type: HealthDataType.ACTIVE_ENERGY_BURNED,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeHealthData(
      value: 70,
      type: HealthDataType.HEART_RATE,
      startTime: earlier,
      endTime: now,
    );
    if (Platform.isIOS) {
      success &= await health.writeHealthData(
        value: 30,
        type: HealthDataType.HEART_RATE_VARIABILITY_SDNN,
        startTime: earlier,
        endTime: now,
      );
    } else {
      success &= await health.writeHealthData(
        value: 30,
        type: HealthDataType.HEART_RATE_VARIABILITY_RMSSD,
        startTime: earlier,
        endTime: now,
      );
    }
    success &= await health.writeHealthData(
      value: 37,
      type: HealthDataType.BODY_TEMPERATURE,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeHealthData(
      value: 105,
      type: HealthDataType.BLOOD_GLUCOSE,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeHealthData(
      value: 1.8,
      type: HealthDataType.WATER,
      startTime: earlier,
      endTime: now,
    );

    // different types of sleep
    success &= await health.writeHealthData(
      value: 0.0,
      type: HealthDataType.SLEEP_REM,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeHealthData(
      value: 0.0,
      type: HealthDataType.SLEEP_ASLEEP,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeHealthData(
      value: 0.0,
      type: HealthDataType.SLEEP_AWAKE,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeHealthData(
      value: 0.0,
      type: HealthDataType.SLEEP_DEEP,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeHealthData(
      value: 22,
      type: HealthDataType.LEAN_BODY_MASS,
      startTime: earlier,
      endTime: now,
    );

    // specialized write methods
    success &= await health.writeBloodOxygen(
      saturation: 98,
      startTime: earlier,
      endTime: now,
    );
    success &= await health.writeWorkoutData(
      activityType: HealthWorkoutActivityType.AMERICAN_FOOTBALL,
      title: "Random workout name that shows up in Health Connect",
      start: now.subtract(const Duration(minutes: 15)),
      end: now,
      totalDistance: 2430,
      totalEnergyBurned: 400,
    );
    success &= await health.writeBloodPressure(
      systolic: 90,
      diastolic: 80,
      startTime: now,
    );
    success &= await health.writeMeal(
      mealType: MealType.SNACK,
      startTime: earlier,
      endTime: now,
      caloriesConsumed: 1000,
      carbohydrates: 50,
      protein: 25,
      fatTotal: 50,
      name: "Banana",
      caffeine: 0.002,
      vitaminA: 0.001,
      vitaminC: 0.002,
      vitaminD: 0.003,
      vitaminE: 0.004,
      vitaminK: 0.005,
      b1Thiamin: 0.006,
      b2Riboflavin: 0.007,
      b3Niacin: 0.008,
      b5PantothenicAcid: 0.009,
      b6Pyridoxine: 0.010,
      b7Biotin: 0.011,
      b9Folate: 0.012,
      b12Cobalamin: 0.013,
      calcium: 0.015,
      copper: 0.016,
      iodine: 0.017,
      iron: 0.018,
      magnesium: 0.019,
      manganese: 0.020,
      phosphorus: 0.021,
      potassium: 0.022,
      selenium: 0.023,
      sodium: 0.024,
      zinc: 0.025,
      water: 0.026,
      molybdenum: 0.027,
      chloride: 0.028,
      chromium: 0.029,
      cholesterol: 0.030,
      fiber: 0.031,
      fatMonounsaturated: 0.032,
      fatPolyunsaturated: 0.033,
      fatUnsaturated: 0.065,
      fatTransMonoenoic: 0.65,
      fatSaturated: 066,
      sugar: 0.067,
      recordingMethod: RecordingMethod.manual,
    );

    success &= await health.writeMenstruationFlow(
      flow: MenstrualFlow.medium,
      isStartOfCycle: true,
      startTime: earlier,
      endTime: now,
    );

    // Available on iOS 16.0+ only
    if (Platform.isIOS) {
      success &= await health.writeHealthData(
        value: 22,
        type: HealthDataType.WATER_TEMPERATURE,
        startTime: earlier,
        endTime: now,
        recordingMethod: RecordingMethod.manual,
      );

      success &= await health.writeHealthData(
        value: 55,
        type: HealthDataType.UNDERWATER_DEPTH,
        startTime: earlier,
        endTime: now,
        recordingMethod: RecordingMethod.manual,
      );
      success &= await health.writeHealthData(
        value: 4.3,
        type: HealthDataType.UV_INDEX,
        startTime: earlier,
        endTime: now,
        recordingMethod: RecordingMethod.manual,
      );
    }

    _state = success ? AppState.DATA_ADDED : AppState.DATA_NOT_ADDED;
  }

  Future<Map<String, Map<String, dynamic>>> fetchAndStoreHealthData(
    String userId,
  ) async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(Duration(days: 2));

    final types = [
      HealthDataType.STEPS,
      // HealthDataType.WEIGHT,
      // HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    final data = await health.getHealthDataFromTypes(
      types: types,
      startTime: thirtyDaysAgo,
      endTime: now,
    );
    print('data : ${data}');

    if (data.isEmpty) return {};

    // 날짜별로 그룹화
    // Map<String, Map<String, num>> grouped = {};
    Map<String, Map<String, dynamic>> grouped = {};

    for (var d in data) {
      final day = DateFormat('yyyy-MM-dd').format(d.dateFrom);

      num value = (d.value as NumericHealthValue).numericValue;

      grouped.putIfAbsent(day, () => {'steps': {}, 'weight': 0, 'calories': 0});

      switch (d.type) {
        case HealthDataType.STEPS:
          final hourKey = DateFormat('yyyy-MM-dd HH').format(d.dateFrom);
          // grouped[day]!['steps'] = grouped[day]!['steps']! + value;

          grouped[day]!['steps'][hourKey] =
              (grouped[day]!['steps'][hourKey] ?? 0) + value;
          // grouped[day]!.putIfAbsent(steps,)

          break;
        case HealthDataType.WEIGHT:
          grouped[day]!['weight'] = value; // 최근 것만 저장
          break;
        case HealthDataType.ACTIVE_ENERGY_BURNED:
          grouped[day]!['calories'] = grouped[day]!['calories']! + value;
          break;
        default:
          break;
      }
    }
    // 20-5

    return grouped;
    // Firestore에 저장

    // final batch = FirebaseFirestore.instance.batch();
    // final healthRef = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userId)
    //     .collection('health_data');

    // final existingDocsSnapshot = await healthRef.get();
    // final existingDataMap = {
    //   for (var doc in existingDocsSnapshot.docs) doc.id: doc.data(),
    // };

    // int addCount = 0;
    // grouped.forEach((day, values) {
    //   final existing = existingDataMap[day];

    //   if (existing == null || !mapEquals(existing, values)) {
    //     addCount++;
    //     final docRef = healthRef.doc(day);
    //     batch.set(docRef, values, SetOptions(merge: true));
    //   }
    // });

    // await batch.commit();

    // print("✅ 30일치 건강 데이터 중 ${addCount}개가 Firestore에 저장 완료");
  }

  Future<List<HealthDataPoint>> fetchDataType({
    required List<HealthDataType> types,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    try {
      final now = endTime ?? DateTime.now();

      final thirtyDaysAgo = now.subtract(Duration(days: 30));

      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: types,
        startTime: thirtyDaysAgo,
        endTime: now,
        // recordingMethodsToFilter: recordingMethodsToFilter,
      );
      healthData.sort((a, b) => b.dateTo.compareTo(a.dateTo));

      return healthData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchData() async {
    _state = AppState.FETCHING_DATA;

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    _healthDataList.clear();

    try {
      // fetch health data
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: types,
        startTime: yesterday,
        endTime: now,
        recordingMethodsToFilter: recordingMethodsToFilter,
      );

      debugPrint(
        'Total number of data points: ${healthData.length}. '
        '${healthData.length > 100 ? 'Only showing the first 100.' : ''}',
      );

      // sort the data points by date
      healthData.sort((a, b) => b.dateTo.compareTo(a.dateTo));

      // save all the new data points (only the first 100)
      _healthDataList.addAll(
        (healthData.length < 100) ? healthData : healthData.sublist(0, 100),
      );
    } catch (error) {
      debugPrint("Exception in getHealthDataFromTypes: $error");
    }

    // filter out duplicates
    _healthDataList = health.removeDuplicates(_healthDataList);

    for (var data in _healthDataList) {
      // debugPrint(toJsonString(data));
      // print('data.toString() : ${data.toString()}');
    }

    // update the UI to display the results
    _state = _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
    print('_healthDataList : ${_healthDataList.length}');
  }

  AppState _state = AppState.DATA_NOT_FETCHED;
  String _contentHealthConnectStatus =
      'No status, click getHealthConnectSdkStatus to get the status.';

  init() {
    health.configure();
    health.getHealthConnectSdkStatus();
  }

  Future<void> authorize() async {
    try {
      await Permission.activityRecognition.request();
      await Permission.location.request();

      // Check if we have health permissions
      bool? hasPermissions = await health.hasPermissions(
        types,
        permissions: permissions,
      );
      print('hasPermissions : ${hasPermissions}');

      // hasPermissions = false because the hasPermission cannot disclose if WRITE access exists.
      // Hence, we have to request with WRITE as well.
      hasPermissions = false;

      bool authorized = false;
      if (!hasPermissions) {
        // requesting access to the data types before reading them
        try {
          authorized = await health.requestAuthorization(
            types,
            permissions: permissions,
          );

          // request access to read historic data
          await health.requestHealthDataHistoryAuthorization();
        } catch (error) {
          debugPrint("Exception in authorize: $error");
        }
      }

      // setState(
      // () =>
      _state = (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED;

      // );
    } catch (e) {
      print('e.toString() : ${e.toString()}');
    }
  }

  List<HealthDataType> get types =>
      (Platform.isAndroid)
          ? dataTypesAndroid
          : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  Future<List<HealthDataPoint>> fetchDataByType(
    List<HealthDataType> types,
  ) async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, 1);
      // final end = DateTime(now.year, now.month, 3);
      final end = DateTime(now.year, now.month + 1).subtract(Duration(days: 1));
      List<HealthDataPoint> healthDatas = await health.getHealthDataFromTypes(
        types: types,
        startTime: DateTime(now.year, now.month, now.day + -1),
        endTime: DateTime(now.year, now.month, now.day + 1),
        recordingMethodsToFilter: recordingMethodsToFilter,
      );
      healthDatas.sort((a, b) => b.dateTo.compareTo(a.dateTo));

      return healthDatas;
    } catch (e) {
      print('e : ${e}');

      rethrow;
    }
  }

  Future<Map<HealthDataType, List<HealthDataPoint>>> fetchDataByType2(
    List<HealthDataType> types,
  ) async {
    try {
      Map<HealthDataType, List<HealthDataPoint>> returnValue = {};
      for (var type in types) {
        returnValue[type] = [];
      }
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, 1);
      // final end = DateTime(now.year, now.month, 3);
      final end = DateTime(now.year, now.month + 1).subtract(Duration(days: 1));
      List<HealthDataPoint> healthDatas = await health.getHealthDataFromTypes(
        types: types,
        startTime: DateTime(now.year, now.month, now.day, 0),
        endTime: DateTime(now.year, now.month, now.day, 23),
        recordingMethodsToFilter: recordingMethodsToFilter,
      );
      healthDatas.sort((a, b) => b.dateTo.compareTo(a.dateTo));

      for (var healthData in healthDatas) {
        returnValue[healthData.type]!.add(healthData);
      }
      return returnValue;
    } catch (e) {
      print('e : ${e}');

      rethrow;
    }
  }

  Future<void> fetchAllData() async {
    final now = DateTime.now();

    final start = DateTime(now.year, now.month, 1);
    // final end = DateTime(now.year, now.month, 3);
    final end = DateTime(now.year, now.month + 1).subtract(Duration(days: 1));

    try {
      List<HealthDataPoint> healthDatas = await health.getHealthDataFromTypes(
        types: types,
        startTime: DateTime(now.year, now.month, now.day + -1),
        endTime: DateTime(now.year, now.month, now.day + 1),
        recordingMethodsToFilter: recordingMethodsToFilter,
      );
      healthDatas.sort((a, b) => b.dateTo.compareTo(a.dateTo));
      print('healthDatas.length : ${healthDatas.length}');

      Map<HealthDataType, List<HealthDataPoint>> temp = {};
      for (var healthData in healthDatas) {
        HealthDataPoint p = healthData;
        if (temp[p.type] == null) {
          temp[p.type] = [];
        }
        temp[p.type]!.add(p);
        if (p.value is AudiogramHealthValue) {
          print('AudiogramHealthValue');
        } else if (p.value is WorkoutHealthValue) {
          print('WorkoutHealthValue');
        } else if (p.value is NutritionHealthValue) {
          print('NutritionHealthValue');
        } else {
          // print('NumericHealthValue');
          // print('p.sourceName : ${p.typeString} : ${p.value}');
        }
      }
      print('temp.keys.length : ${temp.keys.length}');

      print(
        'temp[DIETARY_PROTEIN_CONSUMED] : ${temp[HealthDataType.DIETARY_FATS_CONSUMED]}',
      );

      //DIETARY_PROTEIN_CONSUMED 단백질
      // DIETARY_FATS_CONSUMED 총지방
      //DIETARY_CARBS_CONSUMED  탄수화물
      temp.keys.forEach((e) {
        print('e : ${e}');
      });

      // print('temp : ${temp}');
    } catch (e) {}
  }

  List<HealthDataAccess> get permissions =>
      types
          .map(
            (type) =>
                // can only request READ permissions to the following list of types on iOS
                [
                      HealthDataType.WALKING_HEART_RATE,
                      HealthDataType.ELECTROCARDIOGRAM,
                      HealthDataType.HIGH_HEART_RATE_EVENT,
                      HealthDataType.LOW_HEART_RATE_EVENT,
                      HealthDataType.IRREGULAR_HEART_RATE_EVENT,
                      HealthDataType.EXERCISE_TIME,
                    ].contains(type)
                    ? HealthDataAccess.READ
                    : HealthDataAccess.READ_WRITE,
          )
          .toList();
  int _nofSteps = 0;

  /// Fetch steps from the health plugin and show them in the app.
  Future<Map<String, int>> fetchStepData(
    DateTime startDay,
    DateTime endDay,
  ) async {
    // get steps for today (i.e., since midnight)
    // final now = DateTime.now();
    // final end = DateTime(now.year, now.month + 1).subtract(Duration(days: 1));

    bool stepsPermission =
        await health.hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission = await health.requestAuthorization([
        HealthDataType.STEPS,
      ]);
    }
    if (!stepsPermission) return {};

    Map<String, int> result = {};
    for (var i = -1; i <= 30; i++) {
      int? steps;
      final today = DateTime(endDay.year, endDay.month, endDay.day - i);

      final day = DateFormat('yyyy-MM-dd').format(today);
      result.putIfAbsent(day, () => 0);

      final startTime = DateTime(today.year, today.month, today.day, 0);
      final endTime = DateTime(today.year, today.month, today.day, 23, 59);
      try {
        steps = await health.getTotalStepsInInterval(
          startTime,
          endTime,
          includeManualEntry:
              !recordingMethodsToFilter.contains(RecordingMethod.manual),
        );
        result[day] = steps ?? 0;
      } catch (error) {}
    }
    return result;
  }

  //
  Future<Map<String, HealthDayData>> fetchAndStoreMonthlyHealthData(
    String userId,
  ) async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(Duration(days: 30));

    final types = [
      // HealthDataType.STEPS,
      HealthDataType.DIETARY_PROTEIN_CONSUMED,
      HealthDataType.DIETARY_FATS_CONSUMED,
      HealthDataType.DIETARY_CARBS_CONSUMED,
      HealthDataType.WEIGHT,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    final permissions = types.map((e) => HealthDataAccess.READ).toList();

    // 권한 요청
    final isAuthorized = await health.requestAuthorization(
      types,
      permissions: permissions,
    );
    if (!isAuthorized) {
      print("❌ 건강 데이터 권한 요청 실패");
      return {};
    }

    // 데이터 가져오기
    final data = await health.getHealthDataFromTypes(
      types: types,
      startTime: thirtyDaysAgo,
      endTime: now,
    );

    if (data.isEmpty) {
      print("❗️건강 데이터 없음");
      return {};
    }
    Map<String, HealthDayData> grouped = {};
    Map<String, int> weightCountMap = {};
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(date);
      grouped[key] = HealthDayData(date: key, steps: 0, calories: 0, weight: 0);
      // weightCountMap[key] = 0;
    }
    var stepsPerDay = await fetchStepData(thirtyDaysAgo, now);

    for (var d in data) {
      final day = DateFormat('yyyy-MM-dd').format(d.dateFrom);
      final value = (d.value as NumericHealthValue).numericValue;

      switch (d.type) {
        case HealthDataType.WEIGHT:
          grouped[day] = grouped[day]!.copyWith(
            weight: grouped[day]!.weight + value.toDouble(),
          );
          weightCountMap.putIfAbsent(day, () => 0);
          weightCountMap[day] = weightCountMap[day]! + 1;
          break;
        case HealthDataType.DIETARY_PROTEIN_CONSUMED:
        case HealthDataType.DIETARY_FATS_CONSUMED:
        case HealthDataType.DIETARY_CARBS_CONSUMED:
          grouped[day] = grouped[day]!.copyWith(
            calories: grouped[day]!.calories + value,
          );
          break;
        default:
          break;
      }
    }

    for (var entry in weightCountMap.entries) {
      if (grouped[entry.key] == null) continue;
      grouped[entry.key] = grouped[entry.key]!.copyWith(
        weight: (grouped[entry.key]!.weight / entry.value),
      );
    }
    for (var entry in stepsPerDay.entries) {
      if (grouped[entry.key] == null) continue;
      grouped[entry.key] = grouped[entry.key]!.copyWith(steps: entry.value);
    }

    return grouped;
  }
}
