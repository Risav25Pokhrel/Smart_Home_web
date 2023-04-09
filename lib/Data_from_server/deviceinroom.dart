import 'dart:convert';
import 'package:http/http.dart' as http;
import '../provider/confidential_provider.dart';

Future<List?> getdevicebyroom(String roomid) async {
  try {
    final id =await getid();
    final token = await gettoken();
    // const token =
    //     "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMDk3MTI3MTY0NDUyODc1MzEyNTgiLCJleHAiOjI4NjQ5NjA1MjY1fQ.KHURpPnaSIRnmYEJTxpZKIA4i9H417VOI81Q1uAafPSQ8w3da5eekgHDBIY7Qo6lFykYcS0r_7uiUxirXhcJMg";
    final response = await http.get(
        Uri.parse(
            "https://iotapi.mobiiot.in/msapp/v1/device/device-by-room/$roomid/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["response"];
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
