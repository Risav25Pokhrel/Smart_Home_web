// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_home/Data_from_server/schedular.dart';
import 'package:smart_home/decode/statusdecode.dart';
import 'package:smart_home/model/schedule.dart';

late String deviceId;
final getsedular =
    FutureProvider.autoDispose<List?>((ref) => getScedular(deviceId));

final onstate = StateProvider.autoDispose<bool>((ref) => false);
final dailystate = StateProvider.autoDispose<bool>((ref) => false);
final timestate = StateProvider.autoDispose<String>((ref) {
  String formattedTime = DateFormat.jm().format(DateTime.now());
  return formattedTime;
});
final sendtimestate = StateProvider.autoDispose<String>((ref) {
  return TimeOfDay.now()
      .toString()
      .replaceAll("TimeOfDay", "")
      .replaceAll("(", "")
      .replaceAll(")", "");
});

final datestate = StateProvider.autoDispose<String>((ref) {
  String formattedDate =
      "${DateFormat.d().format(DateTime.now())} ${DateFormat.yMMM().format(DateTime.now())}";
  return formattedDate;
});

class Schedule extends StatefulWidget {
  final Map devicedetail;
  const Schedule({super.key, required this.devicedetail});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  TimeOfDay time = TimeOfDay.now();
  final timername = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    timername.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceId = widget.devicedetail["deviceId"];
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.25 >= 200
              ? MediaQuery.of(context).size.width * 0.25
              : 20,
          vertical: 10),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: TextField(
                  controller: timername,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                      hintText: "Name Your Timer",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer(builder: (context, ref, child) {
              final isOn = ref.watch(onstate);
              final time = ref.watch(timestate);
              final isdaily = ref.watch(dailystate);
              final schedule = ref.watch(getsedular);
              final date = ref.watch(datestate);
              final timeSend = ref.watch(sendtimestate);
              return RefreshIndicator(
                onRefresh: () => ref.refresh(getsedular.future),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Row(children: [
                      Text("Turn ${widget.devicedetail["name"]}  ",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(isOn ? "ON " : "OFF ",
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      Switch(
                          value: isOn,
                          onChanged: (value) =>
                              ref.read(onstate.notifier).state = value)
                    ]),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? settime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              settime ??= TimeOfDay.now();

                              ref.read(timestate.notifier).state =
                                  settime.format(context).toString();

                              ref.read(sendtimestate.notifier).state = settime
                                  .toString()
                                  .replaceAll("TimeOfDay", "")
                                  .replaceAll("(", "")
                                  .replaceAll(")", "");

                              ///date picker is needed
                            },
                            child: const Text("TIME",
                                style: TextStyle(color: Colors.white))),
                        const Text("  at  "),
                        Text(time,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (!isdaily)
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                DateTime? newdate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                );
                                newdate ??= DateTime.now();
                                String formattedDate =
                                    "${DateFormat.d().format(newdate)} ${DateFormat.yMMM().format(newdate)}";
                                ref.read(datestate.notifier).state =
                                    formattedDate;

                                ///date picker is needed
                              },
                              child: const Text("DATE",
                                  style: TextStyle(color: Colors.white))),
                          const Text("  at  "),
                          Text(date,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: isdaily,
                                onChanged: (value) => ref
                                    .read(dailystate.notifier)
                                    .state = value!,
                                checkColor: Colors.white),
                            const Text("Daily",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (timername.text.isEmpty) {
                                showinfo("SET THE TIMER NAME", Colors.red);
                              } else {
                                String datetime = "$date $timeSend";
                                AddSchedule s1 = AddSchedule(
                                    daily: isdaily,
                                    jobTime: datetime,
                                    name: timername.text.toString(),
                                    state: widget.devicedetail["state"],
                                    status: 0,
                                    deviceId: deviceId,
                                    deviceType:
                                        widget.devicedetail["deviceType"],
                                    switchState: isOn,
                                    deviceName: widget.devicedetail["name"]);
                                String message = await addSchedule(s1) ?? "";

                                if (message.isNotEmpty) {
                                  showinfo(message, Colors.orange);
                                  // ignore: unused_result
                                  ref.refresh(getsedular.future);
                                  ref.read(getsedular.future);
                                } else {
                                  showinfo("AN ERROR OCCUR", Colors.red);
                                }
                              }
                            },
                            child: const Text(" SET "))
                      ],
                    ),
                    const Divider(color: Colors.green),
                    const SizedBox(height: 5),
                    schedule.when(
                      error: (error, stackTrace) => const Text(
                          "Sorry!!!An Error Occur",
                          style: TextStyle(color: Colors.red)),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      data: (deviceschedule) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                            itemCount: deviceschedule?.length ?? 0,
                            itemBuilder: (context, index) => Card(
                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                            deviceschedule?[index]["name"] ??
                                                "",
                                            style:
                                                const TextStyle(fontSize: 18),
                                            minFontSize: 10),
                                        Row(
                                          children: [
                                            if (deviceschedule![index]["daily"])
                                              const Text(
                                                "✅ Daily",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12),
                                              ),
                                            if (!deviceschedule[index]["daily"])
                                              Status(
                                                  status: deviceschedule[index]
                                                      ["status"]),
                                            IconButton(
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                        "DELETE SCHEDULE",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      content: const Text(
                                                          "Do you sure want to delete the schedule?",
                                                          style: TextStyle(
                                                              fontSize: 18)),
                                                      actions: [
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              String message =
                                                                  await deleteSchedule(
                                                                          deviceschedule[
                                                                              index]) ??
                                                                      "";
                                                              if (message
                                                                  .isNotEmpty) {
                                                                showinfo(
                                                                    message,
                                                                    Colors
                                                                        .orange);
                                                                // ignore: unused_result
                                                                ref.refresh(
                                                                    getsedular
                                                                        .future);
                                                                ref.read(
                                                                    getsedular
                                                                        .future);
                                                              } else {
                                                                showinfo(
                                                                    "AN ERROR OCCUR",
                                                                    Colors.red);
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "OK")),
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                "CANCEL"))
                                                      ],
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                    Icons.cancel_outlined,
                                                    size: 20))
                                          ],
                                        )
                                      ],
                                    ),
                                    AutoSizeText.rich(TextSpan(
                                        text:
                                            "Turn ${widget.devicedetail["name"]} ",
                                        children: [
                                          TextSpan(
                                              text: deviceschedule[index]
                                                      ["switchState"]
                                                  ? "ON -  "
                                                  : "OFF -  ",
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text: deviceschedule[index]
                                                            ["daily"]
                                                        ? displaytime(
                                                            deviceschedule[
                                                                        index]
                                                                    ["jobTime"]
                                                                .toString())
                                                        : deviceschedule[index]
                                                                ["jobTime"]
                                                            .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal))
                                              ])
                                        ]))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
          )),
    );
  }

  showinfo(String message, Color mycolor) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: mycolor));
  }
}

String displaytime(String time) {
  return time.lastChars(5);
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}
