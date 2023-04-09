import 'package:flutter/material.dart';

import 'autoscrollwidget.dart';

// ignore: camel_case_types
class rightside_companyDetails extends StatelessWidget {
  final double size;
  const rightside_companyDetails({
    super.key,
    this.size = 480,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const Card(
        elevation: 20,
        surfaceTintColor: Colors.yellow,
        child: AutoScrollContent(),
      ),
    );
  }
}
