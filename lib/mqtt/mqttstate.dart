// import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_client.dart';

String broker = "iotapi.mobiiot.in";
String username = "test";
String password = "Mobi@Test#";

final _client = mqtt.MqttBrowserClient(broker, '');

// final MqttBrowserClient _client =
//     MqttBrowserClient(broker, "");

Future<bool> mqttConnect(String uniqueId, String Topic) async {
  _client.autoReconnect = true;
  _client.port = 1883;
  _client.setProtocolV311();
  _client.keepAlivePeriod = 60;
  _client.onConnected = onconnected;
  _client.onDisconnected = ondisconnected;
  _client.logging(on: true);
  _client.pongCallback = pong;

  MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId')
      .withWillTopic('willtopic')
      .withWillMessage('My Will message')
      .startClean()
      .authenticateAs(username, password);

  try {
    await _client.connect(username, password);
  } catch (e) {
    print("ERROR: $e");
  }

  // final MqttConnectMessage connectionMessage =
  //     MqttConnectMessage().withClientIdentifier(uniqueId).startClean();
  // _client.connectionMessage = connectionMessage;

  // await _client.connect("", "");

  // if (_client.connectionStatus!.state == MqttConnectionState.connected) {
  //   print("connected succcessfully");
  // } else {
  //   return false;
  // }

  // _client.subscribe("test", MqttQos.atLeastOnce);
  // await _client.connect(username, password);

  return true;
}

void onconnected() {
  debugPrint("connected successfully my hero");
}

void ondisconnected() {
  print("oh no");
}

void pong() {
  print("");
}
