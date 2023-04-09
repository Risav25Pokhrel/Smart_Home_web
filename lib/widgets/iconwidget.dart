import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final String iconname;
  const MyIcon({super.key, required this.iconname});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 15,
      backgroundImage: AssetImage(iconname),
    );
  }
}
