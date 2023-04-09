// ignore_for_file: use_build_context_synchronously
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/widgets/iconwidget.dart';
import '../Data_from_server/verifytheuser.dart';
import '../googlesigninImplement/google_signin_api.dart';
import '../pages/loggedin_page.dart';

final agreedState = StateProvider.autoDispose<bool>((ref) => false);

class Verificationpart extends ConsumerWidget {
  const Verificationpart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAgreed = ref.watch(agreedState);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(
              value: isAgreed,
              onChanged: (value) =>
                  ref.read(agreedState.notifier).state = !isAgreed,
            ),
            const SizedBox(height: 10),
            const AutoSizeText("I agree The ",
                style: TextStyle(fontWeight: FontWeight.w500), minFontSize: 5),
            InkWell(
              onTap: () {},
              child: const AutoSizeText(
                "Terms And Condition",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                minFontSize: 5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
            onPressed: () async {
              if (isAgreed) {
                try {
                  final user = await GoogleSignInApi.login();
                  final usertoken = await user!.authentication;
                  showstatus(
                      context, "Signing in with Google", Colors.greenAccent);
                  bool isVerified = await getdata(usertoken.idToken ?? '');
                  debugPrint(isVerified.toString());
                  if (user != null && isVerified) {
                    final storeuser = await SharedPreferences.getInstance();
                    storeuser.setString("name", user.displayName ?? "");
                    storeuser.setString("ID", (user.id).toString());
                    storeuser.setString("email", user.email);
                    storeuser.setBool("isfirsttime", false);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => const LoggedInPage()));
                  } else {
                    showstatus(context, "Sign in Failed", Colors.red);
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              } else {
                showstatus(context, "Accept Privacy Policy", Colors.orange);
              }
            },
            icon: const MyIcon(iconname: "assets/google.png"),
            label: const Text("Sign In"))
      ],
    );
  }

  void showstatus(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}
