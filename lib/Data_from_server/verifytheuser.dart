import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getdata(String idToken) async {
  try {
    Response response = await post(
        Uri.parse("https://iotapi.mobiiot.in/msapp/login"),
        headers: {"X-ID-TOKEN": idToken},
        encoding: Encoding.getByName("utf-8"));
    if (response.statusCode == 200) {
      final gettoken = await SharedPreferences.getInstance();
      gettoken.setString("token", response.headers["token"]!);
      return true;
    } else {
      print(response.statusCode.toString());
      debugPrint("an error occur");
      return false;
    }
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
