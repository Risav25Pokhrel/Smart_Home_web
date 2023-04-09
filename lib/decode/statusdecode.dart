import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final int status;
  const Status({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String? statusname;
    Color? mycolor;
    if (status == 0) {
      statusname = "PENDING";
      mycolor = Colors.orange;
    } else if (status == 1) {
      statusname = "EXECUTED";
      mycolor = Colors.green;
    } else {
      statusname = "ERROR";
      mycolor = Colors.red;
    }
    return AutoSizeText(statusname,
        style: TextStyle(color: mycolor, fontSize: 7), minFontSize: 12);
  }
}
