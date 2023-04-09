import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Manualhelp extends StatelessWidget {
  const Manualhelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2 >= 200
              ? MediaQuery.of(context).size.width * 0.2
              : 10,
          vertical: 10),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 50,
                  backgroundImage: AssetImage("assets/help.png")),
            ),
            TextButton(
                onPressed: () {},
                child: const AutoSizeText("INSTRUCTION MANUAL",
                    style: TextStyle(color: Colors.blue, fontSize: 22))),
            TextButton(
                onPressed: () {
                  try {} catch (e) {
                    print(e.toString());
                  }
                },
                child: const AutoSizeText("FAQ",
                    style: TextStyle(color: Colors.blue, fontSize: 22)))
          ],
        ),
      ),
    );
  }
}
