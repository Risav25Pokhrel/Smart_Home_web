import 'package:flutter/material.dart';

class Decodeimage extends StatelessWidget {
  final int code;
  const Decodeimage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    String imagename = '';
    if (code == 1) {
      imagename = 'assets/fan1.png';
    } else if (code == 2) {
      imagename = 'assets/switch1.png';
    } else if (code == 3) {
      imagename = 'assets/socket1.png';
    } else if (code == 4) {
      imagename = 'assets/fan1.png';
    } else if (code == 5) {
      imagename = 'assets/fan1.png';
    } else if (code == 6) {
      imagename = 'assets/valve1.png';
    } else if (code == 7) {
      imagename = 'assets/strip1.png';
    } else if (code == 8) {
      imagename = 'assets/light1.png';
    }
    return SizedBox(
        height: 50,
        width: 80,
        child: Image.asset(imagename, fit: BoxFit.fitHeight));
  }
}
