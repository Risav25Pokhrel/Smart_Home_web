import 'package:flutter/material.dart';

class Noofappliences extends StatelessWidget {
  final int id;
  final Map room;
  const Noofappliences({super.key, required this.id, required this.room});

  @override
  Widget build(BuildContext context) {
    int number = 0;
    int iter = 0;
    for (var i in room["response"]) {
      if (id == room["response"][iter]["room"]) {
        number += 1;
      }
      iter++;
    }

    return Text(
      "$number UTILITIES",
      style: const TextStyle(color: Colors.white, fontSize: 15),
    );
  }
}
