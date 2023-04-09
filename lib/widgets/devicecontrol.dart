import 'package:flutter/material.dart';

// ignore: camel_case_types
class devicecontrol extends StatelessWidget {
  final String controlname;
  final String imageURL;
  const devicecontrol({
    super.key, required this.controlname, required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Card(
            elevation: 15,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: Image.asset(imageURL, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(controlname, style:const TextStyle(fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
