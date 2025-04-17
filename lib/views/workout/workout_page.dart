import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:with_diet/service/health_service.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    HealthService healthService = HealthService();
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final healthDataTypes = [
              HealthDataType.DISTANCE_WALKING_RUNNING,
              HealthDataType.DISTANCE_SWIMMING,
              HealthDataType.DISTANCE_CYCLING,
              HealthDataType.FLIGHTS_CLIMBED,
              HealthDataType.EXERCISE_TIME,
              HealthDataType.WORKOUT,
              HealthDataType.ACTIVE_ENERGY_BURNED,
              HealthDataType.BASAL_ENERGY_BURNED,
            ];
            var returnValues = await healthService.fetchDataByType(
              healthDataTypes,
            );
            Map<HealthDataType, List<HealthDataPoint>> map = {};
            Map<HealthDataType, Map<String, List<HealthDataPoint>>> map2 = {};
            // for (var healthDataType in healthDataTypes) {
            //   map[healthDataType] = [];
            // }

            for (var returnValue in returnValues) {
              if (map[returnValue.type] == null) {
                map[returnValue.type] = [];
                map2[returnValue.type] = {};
              }
              map[returnValue.type]!.add(returnValue);
            }

            for (var entry in map.entries) {
              for (HealthDataPoint healthDataPoint in entry.value) {
                String key = DateFormat(
                  'YYYY-MM-dd',
                ).format(healthDataPoint.dateFrom);
                if (map2[entry.key]![key] == null) {
                  map2[entry.key]![key] = [];
                }
                map2[entry.key]![key]!.add(healthDataPoint);
              }
            }

            for (var entry in map2.entries) {
              for (var entry2 in map2[entry.key]!.entries) {
                var sum = entry2.value!.fold(
                  0.0,
                  (b, a) => b + (a.value as NumericHealthValue).numericValue,
                );
                print('sum : ${sum}');
              }
              print('---------------');
            }
          },
          child: Text('GET'),
        ),
      ],
    );
  }
}
