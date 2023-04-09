import 'package:shared_preferences/shared_preferences.dart';

Future<String> getid() async {
  final getdata = await SharedPreferences.getInstance();
  String id = getdata.getString("ID") ?? "";
  return id;
  // return "110980997334364180151";
}

Future<String> gettoken() async {
  final getdata = await SharedPreferences.getInstance();
  String token = getdata.getString("token") ?? "";
  // const token =
  //     "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMDk3MTI3MTY0NDUyODc1MzEyNTgiLCJleHAiOjI4NjQ5NjA1MjY1fQ.KHURpPnaSIRnmYEJTxpZKIA4i9H417VOI81Q1uAafPSQ8w3da5eekgHDBIY7Qo6lFykYcS0r_7uiUxirXhcJMg";
  return token;
}
