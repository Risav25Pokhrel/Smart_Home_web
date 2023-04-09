// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:smart_home/widgets/verification_signin_widget.dart';

// ignore: camel_case_types
class leftside_company extends StatelessWidget {
  final double height;
  final double width;
  const leftside_company({
    super.key,
    this.height = 100,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 1),
        SizedBox(
          height: height + 50,
          width: width,
          child: Image.asset(
            "assets/head.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
            width: width + 150,
            height: height,
            child: Image.asset(
              "assets/swyamicon.png",
              fit: BoxFit.fill,
            )),
        const SizedBox(height: 10),
        const SizedBox(
          height: 200,
          width: 300,
          child: Verificationpart(),
        ),
        const Spacer(flex: 2)
      ],
    );
  }
}
