import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smart_home/provider/confidential_provider.dart';

Future<Map> getdevices() async {
  try {
    final id = await getid();
    
    final token = await gettoken();
    
    final response = await http.get(
        Uri.parse("https://iotapi.mobiiot.in/msapp/v1/device/devices/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint("Sorry an error occur");
      return {};
    }
  } catch (e) {
    debugPrint(e.toString());
    return {};
  }
}
