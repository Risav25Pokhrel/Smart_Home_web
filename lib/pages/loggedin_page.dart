import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/decode/day_night_decode.dart';
import 'package:smart_home/decode/onoffstate.dart';
import 'package:smart_home/widgets/drawer.dart';
import '../Data_from_server/deviceinfo.dart';
import '../decode/imagedecode.dart';
import '../widgets/featurewidget.dart';
import '../widgets/roommanagement.dart';

final futuredeviceProvider = FutureProvider.autoDispose((ref) => getdevices());

class LoggedInPage extends ConsumerWidget {
  const LoggedInPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceInfo = ref.watch(futuredeviceProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2 >= 200
              ? MediaQuery.of(context).size.width * 0.17
              : 3),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.indigo),
            elevation: 0,
            centerTitle: false,
            title: const Daynight(),
            actions: [
              IconButton(
                  onPressed: () {
                    ref.refresh(futuredeviceProvider);
                    ref.read(futuredeviceProvider.future);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(child: Text("Refreshing Cloud")),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1)));
                  },
                  icon: const Icon(Icons.refresh, color: Colors.green)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
              const SizedBox(width: 50)
            ],
          ),
          drawer: const Drawerstyle(),
          body: ListView(
            padding: const EdgeInsets.all(30),
            children: <Widget>[
              const AutoSizeText("Welcome to SWYAM Smart Home",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  minFontSize: 5),
              deviceInfo.when(
                  error: (error, stackTrace) {
                    ref.refresh(futuredeviceProvider);
                    ref.read(futuredeviceProvider.future);
                    return const Center(child: Text("Connecting with server"));
                  },
                  loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.indigo)),
                  data: (device) {
                    return devicesinfo(context, device);
                  })
            ],
          )),
    );
  }

  SizedBox devicesinfo(BuildContext context, Map<dynamic, dynamic> device) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView(children: [
        AutoSizeText(
            "${device["response"].length} devices is connected to SWYAM cloud",
            maxLines: 1,
            minFontSize: 5),
        const SizedBox(height: 20),
        const Text("Appliences", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
            height: 120,
            child: ListView.builder(
                itemCount: device["response"].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Card(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 5),
                                    child: Decodeimage(
                                        code: device["response"][index]
                                            ["deviceType"])),
                              ),
                              Positioned(
                                  left: 10,
                                  top: 10,
                                  child: SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: Image.asset(
                                        checkonoff(device["response"][index]
                                                ["state"])
                                            ? "assets/ic_status_online.png"
                                            : "assets/ic_status_offline.png",
                                        fit: BoxFit.cover),
                                  ))
                            ],
                          ),
                          Text(
                            device["response"][index]["name"].toString(),
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ))),
        const SizedBox(height: 20),
        const Text("Rooms", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        roomsmanagement(rooms: device),
        const SizedBox(height: 20),
        const Text("Features", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const FeatureWidget()
      ]),
    );
  }
}
