import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'LoginBodywidget.dart';

final activeState = StateProvider.autoDispose<int>((ref) => 0);

class AutoScrollContent extends StatefulWidget {
  final double size;
  const AutoScrollContent({super.key, this.size = 250});

  @override
  State<AutoScrollContent> createState() => _AutoScrollContentState();
}

class _AutoScrollContentState extends State<AutoScrollContent> {
  final scrollcontroller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final activeIndex = ref.watch(activeState);
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CarouselSlider(
                carouselController: scrollcontroller,
                items: [
                  Login_bodywidget(
                      content:
                          'One time login to the Swyam Smart Home Application and convert your home to smart home',
                      imagename: 'assets/onboard_login.png',
                      topic: 'LOGIN',
                      size: widget.size),
                  Login_bodywidget(
                      content:
                          'Add Your Swayam smart home device by scanning QR code and everything would be taken care',
                      imagename: 'assets/onboard_scan_qr.png',
                      topic: 'SCAN QR CODE',
                      size: widget.size),
                  Login_bodywidget(
                      content:
                          'Your Swayam smart home device cloud connection is secure and non hackable,use without worries',
                      imagename: 'assets/onboard_secure_cloud.png',
                      topic: 'SECURE CLOUD',
                      size: widget.size),
                  Login_bodywidget(
                      content:
                          'Device supports Amazon Alexa and Google Home.Control it with your Voice',
                      imagename: 'assets/onboard_alexa.png',
                      topic: 'VOICE CONTROL',
                      size: widget.size),
                ],
                options: CarouselOptions(
                  pageSnapping: true,
                  initialPage: 0,
                  aspectRatio: 1,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    ref.read(activeState.notifier).state = index;
                  },
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () => scrollcontroller.previousPage(),
                  child: const Text("< Previous",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                          fontSize: 15))),
              AnimatedSmoothIndicator(
                onDotClicked: (page) => scrollcontroller.jumpToPage(page),
                effect: const JumpingDotEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: Colors.indigo,
                ),
                activeIndex: activeIndex,
                count: 4,
              ),
              TextButton(
                  onPressed: () => scrollcontroller.nextPage(),
                  child: const Text("Next>",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                          fontSize: 15))),
            ],
          ),
        ],
      );
    });
  }
}
