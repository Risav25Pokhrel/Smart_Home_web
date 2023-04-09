import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/pages/loggedin_page.dart';
import 'package:smart_home/pages/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences data = await SharedPreferences.getInstance();
  bool isFirstLogin = data.getBool("isfirsttime") ?? true;
  runApp(ProviderScope(child: MyApp(loginfirst: isFirstLogin)));
}

class MyApp extends StatelessWidget {
  final bool loginfirst;
  const MyApp({super.key, required this.loginfirst});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SWYAM SMART HOME',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Loginpage());
  }
}
