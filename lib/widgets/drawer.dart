import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/pages/Help.dart';
import 'package:smart_home/pages/appsetting.dart';
import 'package:smart_home/widgets/iconwidget.dart';

Future<List?> getusernameemail() async {
  final getinfo = await SharedPreferences.getInstance();
  String? name = getinfo.getString("name");
  String? email = getinfo.getString("email");
  List<String> detail = [];
  detail.add(name!);
  detail.add(email!);
  return detail;
}

class Drawerstyle extends StatelessWidget {
  const Drawerstyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                  height: 200,
                  width: 300,
                  child: Image.asset("assets/blue_bg.png", fit: BoxFit.fill)),
              Positioned(
                  left: 50,
                  top: 30,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 110,
                        child: Image.asset(
                          "assets/man.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      FutureBuilder(
                        future: getusernameemail(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const SizedBox();

                            default:
                              if (snapshot.hasError) {
                                return const Text("Server error");
                              } else {
                                return Column(
                                  children: <Widget>[
                                    Text(snapshot.data![0],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    Text(snapshot.data![1],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18))
                                  ],
                                );
                              }
                          }
                        },
                      )
                    ],
                  ))
            ],
          ),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Appsetting())),
            leading:const MyIcon(iconname: "assets/setting.png"),
            title: const Text("Settings"),
          ),
          const Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Manualhelp())),
            leading: const MyIcon(iconname: "assets/ic_help.png"),
            title: const Text("Help"),
          ),
          const Divider(),
          const ListTile(
            leading: MyIcon(iconname: "assets/ic_invite_friend.png"),
            title: Text("Invite Friend"),
          ),
          const Divider(),
           const ListTile(
            leading: MyIcon(iconname:"assets/ic_router.png"),
            title: Text("Router Config"),
          )
        ],
      ),
    );
  }
}
