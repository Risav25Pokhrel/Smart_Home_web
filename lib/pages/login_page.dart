import 'package:flutter/material.dart';
import 'package:smart_home/widgets/autoscrollwidget.dart';
import 'package:smart_home/widgets/verification_signin_widget.dart';
import '../widgets/leftside_company_logo.dart';
import '../widgets/rightside_details_widget.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: MediaQuery.of(context).size.width * 0.2 >= 170
                ? const Desktopview()
                : const Mobileview()));
  }
}

// ignore: camel_case_types
class Desktopview extends StatelessWidget {
  const Desktopview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          //leftside of web page
          leftside_company(),
          //rightside of webpage
          rightside_companyDetails(),
        ],
      ),
    );
  }
}

class Mobileview extends StatelessWidget {
  const Mobileview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 150,
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(
                  "assets/head.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 60,
                child: Image.asset(
                  "assets/swyamicon.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 7),
          child: const AspectRatio(
            aspectRatio: 1,
            child: Card(
              elevation: 20,
              child: AutoScrollContent(size: 150),
            ),
          ),
        ),
        const SizedBox(
          height: 100,
          child: Verificationpart(),
        )
      ],
    );
  }
}
