// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home/Data_from_server/delete.dart';
import 'package:smart_home/Data_from_server/moveto.dart';
import 'package:smart_home/Data_from_server/rename.dart';
import 'package:smart_home/decode/imagedecode.dart';
import 'package:smart_home/decode/namedecode.dart';
import 'package:smart_home/mqtt/mqttstate.dart';
import 'package:smart_home/pages/roomdetails_page.dart';
import 'package:smart_home/pages/schedule.dart';
import 'package:smart_home/room/rooms.dart';
import '../decode/onoffstate.dart';
import '../widgets/devicecontrol.dart';

List<String> allrooms = [
  "LIVING ROOM",
  "BEDROOM 1",
  "BEDROOM 2",
  "BEDROOM 3",
  "KITCHEN",
  "WASHROOM 1",
  "OFFICE",
  "WASHROOM 2",
  "OTHERS"
];
String? devicename;
String roomname = "";

final namestate = StateProvider.autoDispose<String?>((ref) => devicename);

class Devicestate extends StatefulWidget {
  final Map device_detail;
  const Devicestate({super.key, required this.device_detail});

  @override
  State<Devicestate> createState() => _DevicestateState();
}

class _DevicestateState extends State<Devicestate> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        devicename = widget.device_detail["name"];
        final DeviceName = ref.watch(namestate);
        final namecontroller = TextEditingController();
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2 >= 200
                  ? MediaQuery.of(context).size.width * 0.2
                  : 10,
              vertical: 10),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                      ("${room[widget.device_detail["room"] - 1]["name"].toString()} - $DeviceName")
                          .toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black)),
                  const SizedBox(height: 5),
                  Namedecode(id: widget.device_detail["deviceType"]),
                  Text(
                    widget.device_detail["deviceId"],
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
              actions: [
                Card(
                  child: IconButton(
                      onPressed: () async {
                        try {
                          await mqttConnect("client-1", "hello");
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      icon: Icon(FontAwesomeIcons.powerOff,
                          color: checkonoff(widget.device_detail["state"])
                              ? Colors.pink
                              : Colors.grey)),
                )
              ],
            ),
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Decodeimage(
                              code: widget.device_detail["deviceType"])),
                      const SizedBox(height: 10),
                      Text(
                        checkonoff(widget.device_detail["state"])
                            ? "ON"
                            : "Off",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Settings",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    padding: const EdgeInsets.only(right: 20),
                    scrollDirection: Axis.horizontal,
                    children: [
////////////////////////////////////////////////////////////////////////////////////////////
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Center(
                                        child: Text("DELETE DEVICE",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red))),
                                    content: const Text(
                                        "Do you really wants to delete the device"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () async {
                                            if (await deletedevice(widget
                                                .device_detail["deviceId"]
                                                .toString())) {
                                              showinfo("Deleted Successfully",
                                                  Colors.green);

                                              Navigator.pop(context);
                                              Navigator.pop(
                                                  context,
                                                  ref.refresh(
                                                      deviceInfo.future));
                                            } else {
                                              showinfo("Sorry!!An error occur",
                                                  Colors.red);

                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text("OK"))
                                    ],
                                  ));
                        },
                        child: const devicecontrol(
                            controlname: 'Delete',
                            imageURL: 'assets/ic_trash.png'),
                      ),
////////////////////////////////////////////////////////////////////////////////////////////
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Schedule(
                                    devicedetail: widget.device_detail))),
                        child: const devicecontrol(
                            controlname: 'Schedule',
                            imageURL: 'assets/timer.png'),
                      ),
////////////////////////////////////////////////////////////////////////////////////////////
                      const devicecontrol(
                          controlname: 'Share', imageURL: 'assets/share.png'),
////////////////////////////////////////////////////////////////////////////////////////////
                      const devicecontrol(
                          controlname: 'Update', imageURL: 'assets/update.png'),
////////////////////////////////////////////////////////////////////////////////////////////
                      const devicecontrol(
                          controlname: 'Restart',
                          imageURL: 'assets/restart.png'),
////////////////////////////////////////////////////////////////////////////////////////////
                      InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Rename Device"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("CANCEL")),
                                      TextButton(
                                          onPressed: () async {
                                            showinfo(
                                                "Changing name to ${namecontroller.text.toString()}",
                                                Colors.green);

                                            final isSuccess =
                                                await renamedevice(
                                                    widget.device_detail[
                                                        "deviceId"],
                                                    namecontroller.text
                                                        .toString());
                                            if (isSuccess) {
                                              ref
                                                      .read(namestate.notifier)
                                                      .state =
                                                  namecontroller.text
                                                      .toString();

                                              Navigator.pop(context);
                                            } else {
                                              showinfo("An error occur!!",
                                                  Colors.red);
                                            }
                                          },
                                          child: const Text("RENAME"))
                                    ],
                                    content: TextField(
                                      controller: namecontroller,
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                        },
                        child: const devicecontrol(
                            controlname: 'Rename', imageURL: 'assets/edit.png'),
                      ),
////////////////////////////////////////////////////////////////////////////////////////////
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("CANCEL")),
                                          TextButton(
                                              onPressed: () async {
                                                if (await movedevice(
                                                    widget.device_detail[
                                                            "deviceId"]
                                                        .toString(),
                                                    (allrooms.indexOf(
                                                                roomname) +
                                                            1)
                                                        .toString())) {
                                                  showinfo(
                                                      "Successfully Moved to $roomname",
                                                      Colors.green);

                                                  Navigator.pop(context);
                                                  Navigator.pop(
                                                      context,
                                                      ref.refresh(
                                                          deviceInfo.future));
                                                } else {
                                                  showinfo("An error occur!!",
                                                      Colors.red);
                                                }
                                              },
                                              child: const Text("MOVE")),
                                        ],
                                        title: Column(
                                          children: [
                                            const Text("Move Device",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blue)),
                                            Text(
                                                "Move $DeviceName from ${room[widget.device_detail["room"] - 1]["name"].toString()} to",
                                                style: const TextStyle(
                                                    fontSize: 15))
                                          ],
                                        ),
                                        content: DropdownButton<String>(
                                          value: roomname.isEmpty
                                              ? room[
                                                  widget.device_detail["room"] -
                                                      1]["name"]
                                              : roomname,
                                          isExpanded: true,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          items: allrooms
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              roomname = value!;
                                            });
                                          },
                                        )),
                                  ));
                        },
                        child: const devicecontrol(
                            controlname: 'Move to',
                            imageURL: 'assets/move.png'),
                      ),
////////////////////////////////////////////////////////////////////////////////////////////
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 15,
                            child: SizedBox(
                              height: 62,
                              width: 62,
                              child: Center(
                                child: Text(
                                  widget.device_detail["version"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text("version",
                              style: TextStyle(fontWeight: FontWeight.w400))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showinfo(String content, Color color) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content), backgroundColor: color));
  }
}
