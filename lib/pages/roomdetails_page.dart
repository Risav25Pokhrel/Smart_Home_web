import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:smart_home/decode/imagedecode.dart';
import 'package:smart_home/decode/onoffstate.dart';
import 'package:smart_home/pages/devicestate.dart';
import 'package:smart_home/pages/loggedin_page.dart';
import '../Data_from_server/deviceinroom.dart';
import '../widgets/nodevice.dart';

String roomNo = "";
final deviceInfo =
    FutureProvider.autoDispose<List?>((ref) => getdevicebyroom(roomNo));

class Roomdetail extends ConsumerWidget {
  final String roomname;
  final String roomno;
  const Roomdetail(this.roomname, this.roomno, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    roomNo = roomno;
    final getdevices = ref.watch(deviceInfo);
    final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2 >= 200
              ? MediaQuery.of(context).size.width * 0.2
              : 5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(
                  context, ref.refresh(futuredeviceProvider.future)),
              icon: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(roomname, style: const TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  ref.refresh(deviceInfo.future);
                  ref.read(deviceInfo.future);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Center(child: Text("Refreshing cloud")),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1)));
                },
                icon: const Icon(Icons.refresh, color: Colors.green)),
            IconButton(
                onPressed: () async {
                  qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                      context: context,
                      onCode: (code) {
                        print(code.toString().replaceAll("Code scanned =", ""));
                      });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Use camera only if you are in mobile app"),
                      backgroundColor: Colors.orangeAccent,
                      duration: Duration(seconds: 6)));
                },
                icon: const Icon(FontAwesomeIcons.qrcode, color: Colors.amber)),
            const SizedBox(width: 50)
          ],
        ),
        body: getdevices.when(
            error: (error, stacktrace) =>
                const Center(child: Text("Server error")),
            loading: () => const Center(
                child: CircularProgressIndicator(color: Colors.indigo)),
            data: (device) {
              if (device == null) {
                return const nodevice_display();
              } else {
                return Center(
                  child: Padding(
                    padding:const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 500,
                      height: 500,
                      child: GridView.builder(
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: device.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  splashColor: Colors.teal,
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => Devicestate(
                                              device_detail: device[index]))),
                                  child: Card(
                                    elevation: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Decodeimage(
                                              code: device[index]
                                                  ["deviceType"]),
                                          AutoSizeText(
                                            device[index]["name"],
                                            maxLines: 1,
                                            minFontSize: 5,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  FontAwesomeIcons.powerOff,
                                                  color: checkonoff(
                                                          device[index]
                                                              ["state"])
                                                      ? Colors.pink
                                                      : Colors.grey))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
