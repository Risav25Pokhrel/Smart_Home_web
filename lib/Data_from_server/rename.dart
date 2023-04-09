import 'package:http/http.dart' ;
import 'package:smart_home/provider/confidential_provider.dart';

Future<bool> renamedevice(String deviceId, String name) async {
  try {
    final token =await gettoken();
    final response = await post(
        Uri.parse(
            "https://iotapi.mobiiot.in/msapp/v1/device/rename/$deviceId/$name"),
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
    print(e.toString());
    return false;
  }
}
