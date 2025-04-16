import 'package:health/health.dart';

extension HealthDataTypeExtension on HealthDataType {
  String get label {
    switch (this) {
      case HealthDataType.STEPS:
        return '걸음 수';
      case HealthDataType.DISTANCE_WALKING_RUNNING:
        return '걷기/달리기 거리';
      case HealthDataType.DISTANCE_SWIMMING:
        return '수영 거리';
      case HealthDataType.DISTANCE_CYCLING:
        return '사이클 거리';
      case HealthDataType.DISTANCE_DELTA:
        return '거리 변화';
      case HealthDataType.FLIGHTS_CLIMBED:
        return '오른 층수';
      case HealthDataType.EXERCISE_TIME:
        return '운동 시간';
      case HealthDataType.WORKOUT:
        return '운동 세션';
      case HealthDataType.ACTIVE_ENERGY_BURNED:
        return '활동으로 소모한 에너지';
      case HealthDataType.BASAL_ENERGY_BURNED:
        return '기초대사량';
      case HealthDataType.TOTAL_CALORIES_BURNED:
        return '총 칼로리 소모량';
      case HealthDataType.DIETARY_ENERGY_CONSUMED:
        return '섭취한 에너지';
      case HealthDataType.DIETARY_CARBS_CONSUMED:
        return '탄수화물 섭취량';
      case HealthDataType.DIETARY_FATS_CONSUMED:
        return '지방 섭취량';
      case HealthDataType.DIETARY_PROTEIN_CONSUMED:
        return '단백질 섭취량';
      case HealthDataType.DIETARY_FIBER:
        return '식이섬유';
      case HealthDataType.DIETARY_SUGAR:
        return '당류';
      case HealthDataType.DIETARY_CAFFEINE:
        return '카페인';
      case HealthDataType.DIETARY_FAT_MONOUNSATURATED:
        return '단일불포화지방산';
      case HealthDataType.DIETARY_FAT_POLYUNSATURATED:
        return '다중불포화지방산';
      case HealthDataType.DIETARY_FAT_SATURATED:
        return '포화지방산';
      case HealthDataType.DIETARY_CHOLESTEROL:
        return '콜레스테롤';
      case HealthDataType.DIETARY_VITAMIN_A:
        return '~ DIETARY_VITAMIN_K	비타민 A ~ K';
      case HealthDataType.DIETARY_FOLATE:
        return '엽산';
      case HealthDataType.DIETARY_CALCIUM:
        return '~ DIETARY_ZINC	칼슘 ~ 아연';
      case HealthDataType.DIETARY_CHROMIUM:
        return '~ DIETARY_SELENIUM	크롬 ~ 셀레늄';
      case HealthDataType.WATER:
        return '물 섭취량';
      case HealthDataType.NUTRITION:
        return '영양 (종합)';
      case HealthDataType.WEIGHT:
        return '체중';
      case HealthDataType.HEIGHT:
        return '키';
      case HealthDataType.BODY_MASS_INDEX:
        return 'BMI';
      case HealthDataType.BODY_FAT_PERCENTAGE:
        return '체지방률';
      case HealthDataType.LEAN_BODY_MASS:
        return '제지방량';
      case HealthDataType.BODY_WATER_MASS:
        return '체수분량';
      case HealthDataType.WAIST_CIRCUMFERENCE:
        return '허리둘레';
      case HealthDataType.HEART_RATE:
        return '심박수';
      case HealthDataType.RESTING_HEART_RATE:
        return '안정 시 심박수';
      case HealthDataType.WALKING_HEART_RATE:
        return '걷기 중 심박수';
      case HealthDataType.HEART_RATE_VARIABILITY_SDNN:
        return '심박 변동성 SDNN';
      case HealthDataType.HEART_RATE_VARIABILITY_RMSSD:
        return '심박 변동성 RMSSD';
      case HealthDataType.HIGH_HEART_RATE_EVENT:
        return '고심박 이벤트';
      case HealthDataType.LOW_HEART_RATE_EVENT:
        return '저심박 이벤트';
      case HealthDataType.IRREGULAR_HEART_RATE_EVENT:
        return '불규칙 심박 이벤트';
      case HealthDataType.ELECTRODERMAL_ACTIVITY:
        return '피부전도도';
      case HealthDataType.ELECTROCARDIOGRAM:
        return '심전도';
      case HealthDataType.BLOOD_PRESSURE_SYSTOLIC:
        return '수축기 혈압';
      case HealthDataType.BLOOD_PRESSURE_DIASTOLIC:
        return '이완기 혈압';
      case HealthDataType.ATRIAL_FIBRILLATION_BURDEN:
        return '심방세동 부담';
      case HealthDataType.RESPIRATORY_RATE:
        return '호흡수';
      case HealthDataType.FORCED_EXPIRATORY_VOLUME:
        return '호기량';
      case HealthDataType.PERIPHERAL_PERFUSION_INDEX:
        return '말초 관류 지수';
      case HealthDataType.BLOOD_GLUCOSE:
        return '혈당';
      case HealthDataType.BLOOD_OXYGEN:
        return '혈중 산소';
      case HealthDataType.INSULIN_DELIVERY:
        return '인슐린 주입';
      case HealthDataType.BODY_TEMPERATURE:
        return '체온';
      case HealthDataType.MINDFULNESS:
        return '마음 챙김 시간';
      case HealthDataType.SLEEP_ASLEEP:
        return '실제 수면 시간';
      case HealthDataType.SLEEP_LIGHT:
        return '얕은 수면';
      case HealthDataType.SLEEP_DEEP:
        return '깊은 수면';
      case HealthDataType.SLEEP_REM:
        return '렘 수면';
      case HealthDataType.SLEEP_AWAKE_IN_BED:
        return '침대에서 깨어있는 시간';
      case HealthDataType.SLEEP_AWAKE:
        return '완전히 깨어있는 시간';
      case HealthDataType.SLEEP_SESSION:
        return '수면 세션';
      case HealthDataType.SLEEP_IN_BED:
        return '침대에 있었던 전체 시간';
      case HealthDataType.SLEEP_OUT_OF_BED:
        return '침대 밖에 있었던 시간';
      case HealthDataType.SLEEP_UNKNOWN:
        return '수면 상태 불명';
      case HealthDataType.HEADACHE_NOT_PRESENT:
        return '두통 없음';
      case HealthDataType.HEADACHE_MILD:
        return '경미한 두통';
      case HealthDataType.HEADACHE_MODERATE:
        return '중간 정도의 두통';
      case HealthDataType.HEADACHE_SEVERE:
        return '심한 두통';
      case HealthDataType.HEADACHE_UNSPECIFIED:
        return '두통 (불특정)';
      case HealthDataType.AUDIOGRAM:
        return '청력 검사 결과';
      case HealthDataType.UV_INDEX:
        return '자외선 지수';
      case HealthDataType.WATER_TEMPERATURE:
        return '수온';
      case HealthDataType.UNDERWATER_DEPTH:
        return '수심';
      case HealthDataType.GENDER:
        return '성별';
      case HealthDataType.BIRTH_DATE:
        return '생년월일';
      case HealthDataType.BLOOD_TYPE:
        return '혈액형';
      case HealthDataType.MENSTRUATION_FLOW:
        return '생리 흐름';
      case HealthDataType.DIETARY_THIAMIN:
        return '비타민 B1';
      case HealthDataType.DIETARY_RIBOFLAVIN:
        return '비타민 B2';
      case HealthDataType.DIETARY_NIACIN:
        return '나이아신 (비타민 B3)';
      case HealthDataType.DIETARY_PANTOTHENIC_ACID:
        return '판토텐산 (비타민 B5)';
      case HealthDataType.DIETARY_VITAMIN_B6:
        return '비타민 B6';
      case HealthDataType.DIETARY_BIOTIN:
        return '비오틴 (비타민 B7)';
      case HealthDataType.DIETARY_VITAMIN_B12:
        return '비타민 B12';
      case HealthDataType.DIETARY_VITAMIN_C:
        return '비타민 C';
      case HealthDataType.DIETARY_VITAMIN_D:
        return '비타민 D';
      case HealthDataType.DIETARY_VITAMIN_E:
        return '비타민 E';
      case HealthDataType.DIETARY_VITAMIN_K:
        return '비타민 K';
      case HealthDataType.DIETARY_IRON:
        return '철분';
      case HealthDataType.DIETARY_MAGNESIUM:
        return '마그네슘';
      case HealthDataType.DIETARY_PHOSPHORUS:
        return '인';
      case HealthDataType.DIETARY_POTASSIUM:
        return '칼륨';
      case HealthDataType.DIETARY_SODIUM:
        return '나트륨';
      case HealthDataType.DIETARY_ZINC:
        return '아연';
      case HealthDataType.DIETARY_CHLORIDE:
        return '염소';
      case HealthDataType.DIETARY_COPPER:
        return '구리';
      case HealthDataType.DIETARY_IODINE:
        return '요오드';
      case HealthDataType.DIETARY_MANGANESE:
        return '망간';
      case HealthDataType.DIETARY_MOLYBDENUM:
        return '몰리브덴';
      case HealthDataType.DIETARY_SELENIUM:
        return '셀레늄';
    }
  }
}

extension HealthDataUnitExtension on HealthDataUnit {
  String get label {
    switch (this) {
      case HealthDataUnit.GRAM:
        return 'g';
      case HealthDataUnit.KILOGRAM:
        return 'kg';
      case HealthDataUnit.OUNCE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.POUND:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.STONE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.METER:
        return 'm';
      case HealthDataUnit.INCH:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.FOOT:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.YARD:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.MILE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.LITER:
        return 'L';
      case HealthDataUnit.MILLILITER:
        return 'mL';
      case HealthDataUnit.FLUID_OUNCE_US:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.FLUID_OUNCE_IMPERIAL:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.CUP_US:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.CUP_IMPERIAL:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.PINT_US:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.PINT_IMPERIAL:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.PASCAL:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.MILLIMETER_OF_MERCURY:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.INCHES_OF_MERCURY:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.CENTIMETER_OF_WATER:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.ATMOSPHERE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.DECIBEL_A_WEIGHTED_SOUND_PRESSURE_LEVEL:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.SECOND:
        return 'second';
      case HealthDataUnit.MILLISECOND:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.MINUTE:
        return 'minute';
      case HealthDataUnit.HOUR:
        return 'hour';
      case HealthDataUnit.DAY:
        return 'day';
      case HealthDataUnit.JOULE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.KILOCALORIE:
        return 'kcal';
      case HealthDataUnit.LARGE_CALORIE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.SMALL_CALORIE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.DEGREE_CELSIUS:
        return '°C';
      case HealthDataUnit.DEGREE_FAHRENHEIT:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.KELVIN:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.DECIBEL_HEARING_LEVEL:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.HERTZ:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.SIEMEN:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.VOLT:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.INTERNATIONAL_UNIT:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.COUNT:
        return '보';
      case HealthDataUnit.PERCENT:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.BEATS_PER_MINUTE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.RESPIRATIONS_PER_MINUTE:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.MILLIGRAM_PER_DECILITER:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.UNKNOWN_UNIT:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HealthDataUnit.NO_UNIT:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}

List<HealthDataType> iosAndAos = [
  HealthDataType.ACTIVE_ENERGY_BURNED,
  HealthDataType.BASAL_ENERGY_BURNED,
  HealthDataType.BLOOD_GLUCOSE,
  HealthDataType.BLOOD_OXYGEN,
  HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
  HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
  HealthDataType.BODY_FAT_PERCENTAGE,
  HealthDataType.LEAN_BODY_MASS,
  HealthDataType.BODY_MASS_INDEX,
  HealthDataType.BODY_TEMPERATURE,
  HealthDataType.BODY_WATER_MASS,
  HealthDataType.HEART_RATE,
  HealthDataType.HEART_RATE_VARIABILITY_RMSSD,
  HealthDataType.HEIGHT,
  HealthDataType.STEPS,
  HealthDataType.WEIGHT,
  HealthDataType.DISTANCE_DELTA,
  HealthDataType.SLEEP_ASLEEP,
  HealthDataType.SLEEP_AWAKE_IN_BED,
  HealthDataType.SLEEP_AWAKE,
  HealthDataType.SLEEP_DEEP,
  HealthDataType.SLEEP_LIGHT,
  HealthDataType.SLEEP_OUT_OF_BED,
  HealthDataType.SLEEP_REM,
  HealthDataType.SLEEP_SESSION,
  HealthDataType.SLEEP_UNKNOWN,
  HealthDataType.WATER,
  HealthDataType.WORKOUT,
  HealthDataType.RESTING_HEART_RATE,
  HealthDataType.FLIGHTS_CLIMBED,
  HealthDataType.RESPIRATORY_RATE,
  HealthDataType.NUTRITION,
  HealthDataType.TOTAL_CALORIES_BURNED,
  HealthDataType.MENSTRUATION_FLOW,
];
