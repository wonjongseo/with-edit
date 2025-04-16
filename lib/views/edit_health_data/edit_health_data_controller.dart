import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:with_diet/controller/data_controller.dart';
import 'package:with_diet/core/enums/calory_type.dart';
import 'package:with_diet/core/enums/home_graph_type.dart';
import 'package:with_diet/core/utils/app_function.dart';
import 'package:with_diet/core/utils/app_snackbar.dart';
import 'package:with_diet/service/health_service.dart';

class EditHealthDataController extends GetxController {
  EditHealthDataController({
    HomeGraphType? type,
    DateTime? date,
    this.healthDataPoint,
  }) : selectedHealthType = type,
       selectedDateTime = date ?? DateTime.now();

  @override
  void onInit() {
    if (healthDataPoint != null) {
      setHealthDataPoint();
    }
    super.onInit();
  }

  void setHealthDataPoint() {}

  HealthDataPoint? healthDataPoint;
  HealthService _healthService = HealthService();
  DataController _dataController = Get.find<DataController>();

  TextEditingController teCtl = TextEditingController();

  DateTime selectedDateTime;

  HomeGraphType? selectedHealthType;
  CaloryType? selectedCaloryType;

  Future<void> onChangeDateTime(BuildContext context) async {
    DateTime? dateTime = await AppFunction.pickDate(context);
    if (dateTime == null) return;
    selectedDateTime = dateTime;
    update();
  }

  void onChangeHealthType(HomeGraphType? type) {
    if (type == null) return;
    selectedHealthType = type;

    if (selectedHealthType == HomeGraphType.calory) {
      selectedCaloryType = CaloryType.carbohydrate;
    }
    teCtl.clear();
    update();
  }

  void onChangeCaloryType(CaloryType? type) {
    if (type == null) return;
    selectedCaloryType = type;
    update();
  }

  Future<void> onSave() async {
    if (teCtl.text.isEmpty) {
      return;
    }
    if (selectedHealthType == null) {
      return;
    }
    HealthDataType type;
    switch (selectedHealthType!) {
      case HomeGraphType.step:
        type = HealthDataType.STEPS;
      case HomeGraphType.calory:
        switch (selectedCaloryType!) {
          case CaloryType.carbohydrate:
            type = HealthDataType.DIETARY_CARBS_CONSUMED;
          case CaloryType.protein:
            type = HealthDataType.DIETARY_PROTEIN_CONSUMED;
          case CaloryType.fat:
            type = HealthDataType.DIETARY_FATS_CONSUMED;
        }
      case HomeGraphType.weight:
        type = HealthDataType.WEIGHT;
    }
    try {
      await _healthService.addDataByType(
        type: type,
        value: double.parse(teCtl.text),
        date: selectedDateTime,
      );
      teCtl.clear();
      _dataController.loadHealthData();
      AppSnackbar.showSuccessSnackBar(message: '등록에 성공하였습니다.');
    } catch (e) {
      print(e.toString());
      AppSnackbar.showErrorSnackBar(message: '등록에 실패하였습니다. $e');
    }
  }
}
