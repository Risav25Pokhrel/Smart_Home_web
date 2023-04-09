import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


//rightside of the webpage
class Login_bodywidget extends StatelessWidget {
  final String topic;
  final String imagename;
  final String content;
  final double size;
  const Login_bodywidget({
    super.key,
    required this.topic,
    required this.imagename,
    required this.content,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
      child: ListView(
        children: <Widget>[
          SizedBox(
              height: size,
              width: size,
              child: Image.asset(imagename, fit: BoxFit.fill)),
          const SizedBox(height: 10),
          Center(
            child: AutoSizeText(topic,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
                minFontSize: 5,
                maxLines: 1),
          ),
          const SizedBox(height: 10),
          AutoSizeText(content,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 18),
              minFontSize: 2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
