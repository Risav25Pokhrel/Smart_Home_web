import 'package:flutter/material.dart';

class Namedecode extends StatelessWidget {
  final int id;
  const Namedecode({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String devicename = "";
    if (id == 1) {
      devicename = 'SWYAM Smart Fan';
    } else if (id == 2) {
      devicename = 'SWYAM Smart Switch';
    } else if (id == 3) {
      devicename = 'SWYAM Smart Socket';
    } else if (id == 4) {
      devicename = 'SWYAM Smart Cooler';
    } else if (id == 5) {
      devicename = 'SWYAM Smart Pump';
    } else if (id == 6) {
      devicename = 'SWYAM Smart Valve';
    } else if (id == 7) {
      devicename = 'SWYAM Smart Power Strip';
    } else if (id == 8) {
      devicename = 'SWYAM Smart Light';
    }
    return Text(
      devicename,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w300, color: Colors.black),
    );
  }
}
