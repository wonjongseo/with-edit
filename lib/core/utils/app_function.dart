import 'package:flutter/material.dart';

class AppFunction {
  // Date
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? firstDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
          firstDate ?? DateTime.now().subtract(const Duration(days: 365 * 3)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
  }

  // DropdownButton2
  static void openDropdown(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context == null) return;

      GestureDetector? detector;

      void findGestureDetector(Element element) {
        if (element.widget is GestureDetector) {
          final candidate = element.widget as GestureDetector;
          if (candidate.onTap != null) {
            detector = candidate;
          }
        }
        element.visitChildren(findGestureDetector);
      }

      context.visitChildElements(findGestureDetector);

      if (detector?.onTap != null) {
        detector!.onTap!();
      } else {
        print("GestureDetector with onTap not found.");
      }
    });
  }
}
