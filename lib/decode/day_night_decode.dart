import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Daynight extends StatelessWidget {
  const Daynight({super.key});

  @override
  Widget build(BuildContext context) {
    String? condition;
    final check = TimeOfDay.now();

    if (check.hour >= 20 && check.hour <= 24) {
      condition = "Night";
    } else if (check.hour >= 0 && check.hour < 9) {
      condition = "Morning";
    } else if (check.hour >= 9 && check.hour < 12) {
      condition = "Broad Daylight";
    } else if (check.hour >= 12 && check.hour < 17) {
      condition = "Afternoon";
    } else if (check.hour >= 17 && check.hour < 20) {
      condition = "Evening";
    }

    return AutoSizeText("Good $condition",
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        minFontSize: 10);
  }
}
