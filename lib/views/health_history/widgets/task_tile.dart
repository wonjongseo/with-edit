import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:with_diet/extentions.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.healthDataPoint});
  final HealthDataPoint healthDataPoint;
  @override
  Widget build(BuildContext context) {
    int value = 0;
    if (healthDataPoint.value is NutritionHealthValue) {
    } else if (healthDataPoint.value is NumericHealthValue) {
      value =
          (healthDataPoint.value as NumericHealthValue).numericValue.toInt();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    healthDataPoint.type.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '$value ${healthDataPoint.unit.label}',
                    style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${DateFormat.Hm().format(healthDataPoint.dateFrom)} - ${DateFormat.Hm().format(healthDataPoint.dateTo)}',
                        style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: .5,
              color: Colors.grey[200]!.withOpacity(.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                'COMPLETED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBGClr(int index) {
    return Colors.grey;
    // switch (index) {
    //   case 0:
    //     return primaryClr;
    //   case 1:
    //     return pinkClr;
    //   case 2:
    //     return yellowClr;

    //   default:
    //     return primaryClr;
    // }
  }
}
