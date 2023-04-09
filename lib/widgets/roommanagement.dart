import 'package:flutter/material.dart';
import 'package:smart_home/decode/noofappliencesinroom.dart';
import 'package:smart_home/pages/roomdetails_page.dart';

import '../room/rooms.dart';

class roomsmanagement extends StatelessWidget {
  final Map rooms;
  const roomsmanagement({
    super.key,
    required this.rooms,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: ListView.builder(
            itemCount: room.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Roomdetail(room[index]["name"] ?? "",
                            (index + 1).toString()))),
                    child: Card(
                        color: color[index],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 180,
                            width: 150,
                            child: Column(
                              children: [
                                Text(room[index]["name"] ?? "",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                                const Spacer(flex: 1),
                                SizedBox(
                                  height: 55,
                                  child: Image.asset(room[index]["imageURL"]!,
                                      fit: BoxFit.cover),
                                ),
                                const Spacer(flex: 1),
                                Noofappliences(id: index + 1, room: rooms),
                              ],
                            ),
                          ),
                        )),
                  ),
                )));
  }
}
