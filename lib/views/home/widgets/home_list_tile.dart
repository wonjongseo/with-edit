import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeListTile extends StatelessWidget {
  const HomeListTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.sufficText,
    this.todayValue,
    this.yesterDayValue,
    required this.containerColor,
    required this.icon,
  });
  final Function() onTap;
  final String title;
  final String sufficText;
  final int? todayValue;
  final int? yesterDayValue;
  // final String count;
  final Color containerColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    int diff = (todayValue ?? 0) - (yesterDayValue ?? 0);

    String diffValue =
        yesterDayValue == null
            ? '이전 데이터가 없습니다.'
            : diff > 0
            ? '+$diff $sufficText'
            : '$diff $sufficText';

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Text(diffValue),
              ],
            ),
            Spacer(),
            if (todayValue == null)
              Text(
                '건강 데이터가 없습니다',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              )
            else
              Text(
                // '${NumberFormat('#.0').format(todayValue!)} $sufficText',
                '${NumberFormat.decimalPattern().format(todayValue!)} $sufficText',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
