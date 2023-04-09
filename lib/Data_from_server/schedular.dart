import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:smart_home/model/schedule.dart";
import "package:smart_home/provider/confidential_provider.dart";
import 'package:http/http.dart';

//********************************************************************/
Future<List?> getScedular(String deviceId) async {
  final token =await gettoken();
  try {
    final response = await http.get(
        Uri.parse("https://iotapi.mobiiot.in/msapp/v1/scheduler/get/$deviceId"),
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
    debugPrint(e.toString());
    return null;
  }
}
//********************************************************************/

Future<String?> addSchedule(AddSchedule s1) async {
  final token =await gettoken();

  Map data = {
    "schedulerId": s1.schedularid,
    "jobTime": s1.jobTime,
    "daily": s1.daily,
    "name": s1.name,
    "state": s1.state,
    "status": s1.status,
    "deviceId": s1.deviceId,
    "deviceType": s1.deviceType,
    "switchState": s1.switchState,
    "deviceName": s1.deviceName
  };
  var body = json.encode(data);

  try {
    final response = await post(Uri.parse("https://iotapi.mobiiot.in/msapp/v1/scheduler/add"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body);

    if (response.statusCode == 200) {
      final message = jsonDecode(response.body);
      return message["message"];
    } else {
      return "AN ERROR OCCUR";
    }
  } catch (e) {
    debugPrint(e.toString());
    return "AN ERROR OCCUR";
  }
}

//********************************************************************/

Future<String?> deleteSchedule(Map data) async {
  final token =await gettoken();
  var body = json.encode(data);

  try {
    final response = await post(Uri.parse("https://iotapi.mobiiot.in/msapp/v1/scheduler/delete"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body);

    if (response.statusCode == 200) {
      final message = jsonDecode(response.body);
      return message["message"];
    } else {
      return "AN ERROR OCCUR";
    }
  } catch (e) {
    debugPrint(e.toString());
    return "AN ERROR OCCUR";
  }
}

