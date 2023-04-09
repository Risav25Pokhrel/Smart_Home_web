import 'package:flutter/material.dart';

class Dailytimedecode extends StatelessWidget {
  final String time;
  const Dailytimedecode({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final dailytime = time.lastChars(4);
    return Text(dailytime.toString());
  }
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}
