import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:smart_home/provider/confidential_provider.dart';

Future<bool> deletedevice(String deviceId) async {
  final id = await getid();
  final token =await gettoken();

  try {
    Response response = await delete(
        Uri.parse(
            "https://iotapi.mobiiot.in/msapp/v1/device/delete/$deviceId/$id"),
        headers: {
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
