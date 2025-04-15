import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:with_diet/service/health_service.dart';

List<HealthDataType> foodHealthDataType = [
  HealthDataType.DIETARY_PROTEIN_CONSUMED,
  HealthDataType.DIETARY_FATS_CONSUMED,
  HealthDataType.DIETARY_CARBS_CONSUMED,
];

class AddHealthDataWidet extends StatefulWidget {
  const AddHealthDataWidet({super.key});

  @override
  State<AddHealthDataWidet> createState() => _AddHealthDataWidetState();
}

class _AddHealthDataWidetState extends State<AddHealthDataWidet> {
  HealthDataType? selectedIndex;
  TextEditingController teCtl = TextEditingController(text: '20');
  HealthService healthService = HealthService();
  void selectFoodType(HealthDataType index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  void dispose() {
    teCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(foodHealthDataType.length, (index) {
              HealthDataType type = foodHealthDataType[index];
              if (type == HealthDataType.DIETARY_PROTEIN_CONSUMED) {
                return InkWell(
                  onTap: () {
                    selectFoodType(HealthDataType.DIETARY_PROTEIN_CONSUMED);
                  },
                  child: FoodTypeWidget(
                    label: '단백질',
                    color:
                        selectedIndex == HealthDataType.DIETARY_PROTEIN_CONSUMED
                            ? Colors.redAccent
                            : Colors.white,
                  ),
                );
              } else if (type == HealthDataType.DIETARY_FATS_CONSUMED) {
                return InkWell(
                  onTap: () {
                    selectFoodType(HealthDataType.DIETARY_FATS_CONSUMED);
                  },
                  child: FoodTypeWidget(
                    label: '지방',
                    color:
                        selectedIndex == HealthDataType.DIETARY_FATS_CONSUMED
                            ? Colors.redAccent
                            : Colors.white,
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    selectFoodType(HealthDataType.DIETARY_CARBS_CONSUMED);
                  },
                  child: FoodTypeWidget(
                    label: '탄수화물',
                    color:
                        selectedIndex == HealthDataType.DIETARY_CARBS_CONSUMED
                            ? Colors.redAccent
                            : Colors.white,
                  ),
                );
              }
            }),
          ),
          SizedBox(height: 20),
          TextFormField(controller: teCtl),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  healthService.addDataByType(
                    selectedIndex!,
                    double.parse(teCtl.text),
                  );
                },
                child: Text('등록'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FoodTypeWidget extends StatelessWidget {
  const FoodTypeWidget({super.key, required this.label, required this.color});

  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
