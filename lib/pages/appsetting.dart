import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../googlesigninImplement/google_signin_api.dart';
import 'login_page.dart';

class Appsetting extends StatelessWidget {
  const Appsetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2 >= 200
                ? MediaQuery.of(context).size.width * 0.17
                : 3),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 30),
            const Center(
              child: CircleAvatar(
                radius: 130,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/setting.png"),
              ),
            ),
            ListTile(
              trailing: ElevatedButton(
                  onPressed: () {},
                  child:
                      const AutoSizeText("READ", maxLines: 2, minFontSize: 5)),
              title: const AutoSizeText("PRIVACY POLICY",
                  maxLines: 2, minFontSize: 5),
            ),
            const Divider(),
            ListTile(
              trailing: ElevatedButton(
                  onPressed: () {},
                  child:
                      const AutoSizeText("READ", maxLines: 1, minFontSize: 5)),
              title:
                  const AutoSizeText("AGREEMENT", maxLines: 2, minFontSize: 5),
            ),
            const Divider(),
            const ListTile(
              title: AutoSizeText("CONTACT US", maxLines: 2, minFontSize: 5),
              subtitle: AutoSizeText("contact@mobilot.in",
                  maxLines: 2, minFontSize: 5),
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await GoogleSignInApi.logout();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Loginpage()));
                  },
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text("LOGOUT")),
            )
          ],
        ),
      ),
    );
  }
}
