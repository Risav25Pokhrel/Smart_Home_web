import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class nodevice_display extends StatelessWidget {
  const nodevice_display({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AspectRatio(
      aspectRatio: 9 / 8,
      child: Center(
        child: ListView(
          children: [
            const Center(
                child:
                    AutoSizeText("Add Device", style: TextStyle(fontSize: 20))),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 50),
              child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset("assets/no_device_found.png",
                      fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    ));
  }
}
