import 'package:health/health.dart';

enum HomeGraphType { step, calory, weight }

extension HomeGraphTypeExtension on HomeGraphType {
  List<HealthDataType> get healthDataTypes {
    switch (this) {
      case HomeGraphType.step:
        return [HealthDataType.STEPS];
      case HomeGraphType.calory:
        return [
          HealthDataType.DIETARY_CARBS_CONSUMED,
          HealthDataType.DIETARY_PROTEIN_CONSUMED,
          HealthDataType.DIETARY_FATS_CONSUMED,
        ];
      case HomeGraphType.weight:
        return [HealthDataType.WEIGHT];
    }
  }

  String get label {
    switch (this) {
      case HomeGraphType.step:
        return '걸음 수';
      case HomeGraphType.calory:
        return '섭취 칼로리';
      case HomeGraphType.weight:
        return '몸무게';
    }
  }

  String get suffic {
    switch (this) {
      case HomeGraphType.step:
        return '보';
      case HomeGraphType.calory:
        return 'kcal';
      case HomeGraphType.weight:
        return 'kg';
    }
  }
}
