import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:smart_home/provider/confidential_provider.dart';

Future<bool> movedevice(String deviceId, String room) async {
  try {
    final token =await gettoken();
    final response = await post(
        Uri.parse(
            "https://iotapi.mobiiot.in/msapp/v1/device/update-room/$deviceId/$room"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
